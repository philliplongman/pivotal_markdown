require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Token do

      let(:config)       { Config.new }

      let(:stories)      { "spec/fixtures/stories.md" }
      let(:no_project)   { "spec/fixtures/stories-no-project.md" }
      let(:wrong_format) { "spec/fixtures/stories.txt" }

      let(:success_msg) do
        [
          "(00000) Steal the Maltese Falcon",
          "  Example feature",
          "  Example feature II",
          "  Example bug (bug)",
          "  Example chore (chore)"
        ]
      end

      describe '#stories' do
        it "parses and uploads the stories" do
          config.update(api_token: "valid token", default_project: "00000")
          success_msg.each { |line| expect(STDOUT).to receive(:puts).with line }
          Upload.new.stories stories
        end

        it "uses the project specified in the file" do
          config.update(api_token: "valid token", default_project: "11111")
          success_msg.each { |line| expect(STDOUT).to receive(:puts).with line }
          Upload.new.stories stories
        end

        it "uploads to default project if none is specified in the file" do
          config.update(api_token: "valid token", default_project: "00000")
          success_msg.each { |line| expect(STDOUT).to receive(:puts).with line }
          Upload.new.stories no_project
        end

        it "fails if no project is specified in either place" do
          config.update(api_token: "valid token")
          output = ["No project specified in file.", Message.no_default_project]
          output.each { |line| expect(STDOUT).to receive(:puts).with line }
          -> { Upload.new.stories no_project }.should raise_error SystemExit
        end

        it "fails with an invalid project" do
          config.update(api_token: "valid token", default_project: "invalid ID")
          output = "The object you tried to access could not be found...\n\n"
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories no_project
        end

        it "fails without an API token" do
          expect(STDOUT).to receive(:puts).with Message.no_api_token
          Upload.new.stories stories
        end

        it "fails with an invalid API token" do
          config.update(api_token: "invalid token")
          output = "Invalid authentication credentials were presented.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories stories
        end

        it "fails if the file doesn't exist" do
          output = "File not found steal-the-maltese-falcon.md\n\n"
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories "steal-the-maltese-falcon.md"
        end

        it "fails if the file is not a Markdown file" do
          expect(STDOUT).to receive(:puts).with Message.non_markdown_file
          Upload.new.stories wrong_format
        end
      end

    end
  end
end
