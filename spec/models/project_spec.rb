require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Project do

      let(:config) { Config.new }

      describe '#set' do
        it "verifies the project" do
          config.api_token = "valid token"
          config.save

          output = "Default project set to (00000) Steal the Maltese Falcon.\n\n"
          expect(STDOUT).to receive(:puts).with output
          valid_id = "00000"
          Project.new.set valid_id
        end

        it "configures the default project" do
          config.api_token = "valid token"
          config.save

          valid_id = "00000"
          Project.new.set valid_id
          expect(config.default_project).to eq valid_id
        end

        it "fails if the project is invalid" do
          config.api_token = "valid token"
          config.save

          output = "The object you tried to access could not be found...\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.set "invalid ID"
          expect(config.default_project).to eq nil
        end
      end

      describe '#check' do
        it "displays the configured project" do
          valid_id = "00000"
          config.api_token = "valid token"
          config.default_project = valid_id
          config.save

          output = "Default project set to (00000) Steal the Maltese Falcon.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "gives instructions if there is no default project configured" do
          config.api_token = "valid token"
          config.save

          expect(STDOUT).to receive(:puts).with Message.no_default_project
          Project.new.check
        end

        it "fails if the project is invalid" do
          config.api_token = "valid token"
          config.default_project = "invalid ID"
          config.save

          output = "The object you tried to access could not be found...\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end
      end

      describe '#reset' do
        it "resets the default project" do
          config.default_project = "project"
          config.save

          output = "Default project reset.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.reset
          expect(config.default_project).to be nil
        end
      end

      context "when there is no API token configured" do
        describe '#set' do
          it "fails" do
            expect(STDOUT).to receive(:puts).with Message.no_api_token
            Project.new.set "valid ID"
            expect(config.default_project).to eq nil
          end
        end

        describe '#check' do
          it "fails" do
            expect(STDOUT).to receive(:puts).with Message.no_api_token
            Project.new.check
          end
        end
      end

      context "when the configured API token is invalid" do
        let(:output) { "Invalid authentication credentials were presented.\n\n" }

        describe '#set' do
          it "fails" do
            config.api_token = "invalid token"
            config.save

            expect(STDOUT).to receive(:puts).with output
            Project.new.set "valid ID"
            expect(config.default_project).to eq nil
          end
        end

        describe '#check' do
          it "fails" do
            config.api_token = "invalid token"
            config.default_project = "valid ID"
            config.save

            expect(STDOUT).to receive(:puts).with output
            Project.new.check
          end
        end
      end

    end
  end
end
