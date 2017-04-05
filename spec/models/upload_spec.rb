require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Token do

      let(:stories)      { "spec/fixtures/stories.md" }
      let(:no_project)   { "spec/fixtures/stories-no-project.md" }
      let(:wrong_format) { "spec/fixtures/stories.txt" }

      let(:config) { Config.new }

      describe '#stories' do
        pending "parses and uploads the stories" do
          config.api_token = "valid token"
          config.default_project = "00000"
          config.save
          fail
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

        context "with default project" do
          before :each do
            config.api_token = "valid token"
            config.default_project = "00000"
            config.save
          end

          pending "uploads without having to specify a project"

          pending "uploads to the project specified in the file"
        end

        context "without default project" do
          before :each do
            config.api_token = "valid token"
            config.save
          end

          pending "fails if no project is specified in the file"
        end

        pending "with invalid project"

        context "without API token" do
          it "fails" do
            expect(STDOUT).to receive(:puts).with Message.no_api_token
            Upload.new.stories stories
          end
        end

        pending "with invalid API token"
      end

    end
  end
end
