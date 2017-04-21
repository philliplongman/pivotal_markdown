require 'spec_helper'

module PivotalMarkdown
  module CLI

    describe Upload do
      let(:config)       { Config.new }

      let(:stories)      { "spec/fixtures/stories.md" }
      let(:no_project)   { "spec/fixtures/stories-no-project.md" }
      let(:wrong_format) { "spec/fixtures/stories.txt" }

      let(:success_message) do
        {
          project: "(00000) Steal the Maltese Falcon",
          stories: [
            "  Example feature",
            "  Example feature II",
            "  Example bug (bug)",
            "  Example chore (chore)"
          ]
        }
      end

      describe '#stories' do
        it "parses and uploads the stories" do
          config.update(api_token: "valid token", default_project: "00000")
          expect(STDOUT).to receive(:puts).with success_message[:project]
          expect(STDOUT).to receive(:puts).with success_message[:stories]
          Upload.new.stories stories
        end

        it "uses the project specified in the file" do
          config.update(api_token: "valid token", default_project: "11111")
          expect(STDOUT).to receive(:puts).with success_message[:project]
          Upload.new.stories stories
        end

        it "uploads to default project if none is specified in the file" do
          config.update(api_token: "valid token", default_project: "00000")
          expect(STDOUT).to receive(:puts).with success_message[:project]
          Upload.new.stories no_project
        end

        it "fails if no project is specified in either place" do
          config.update(api_token: "valid token")
          expect(STDOUT).to receive(:puts).with "No project specified in file."
          expect(STDOUT).to receive(:puts).with NoProjectError.new.message
          Upload.new.stories no_project
        end

        it "fails with an invalid project" do
          config.update(api_token: "valid token", default_project: "invalid ID")
          output = "The object you tried to access could not be found..."
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories no_project
        end

        it "fails without an API token" do
          expect(STDOUT).to receive(:puts).with NoTokenError.new.message
          Upload.new.stories stories
        end

        it "fails with an invalid API token" do
          config.update(api_token: "invalid token")
          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories stories
        end

        it "fails if the file doesn't exist" do
          output = "File not found steal-the-maltese-falcon.md"
          expect(STDOUT).to receive(:puts).with output
          Upload.new.stories "steal-the-maltese-falcon.md"
        end

        it "fails if the file is not a Markdown file" do
          expect(STDOUT).to receive(:puts).with MarkdownFormatError.new.message
          Upload.new.stories wrong_format
        end
      end

    end
  end
end
