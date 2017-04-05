require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Project do

      let(:config) { Config.new }

      describe '#set' do
        it "verifies the project" do
          config.update(api_token: "valid token")
          output = "Default project set to (00000) Steal the Maltese Falcon.\n\n"
          expect(STDOUT).to receive(:puts).with output
          valid_id = "00000"
          Project.new.set valid_id
        end

        it "configures the default project" do
          config.update(api_token: "valid token")
          valid_id = "00000"
          Project.new.set valid_id
          expect(config.default_project).to eq valid_id
        end

        it "fails if the project is invalid" do
          config.update(api_token: "valid token")
          output = "The object you tried to access could not be found...\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.set "invalid ID"
          expect(config.default_project).to eq nil
        end
      end

      describe '#check' do
        it "displays the configured project" do
          config.update(api_token: "valid token", default_project: "00000")
          output = "Default project set to (00000) Steal the Maltese Falcon.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "gives instructions if there is no default project configured" do
          config.update(api_token: "valid token")
          expect(STDOUT).to receive(:puts).with Message.no_default_project
          Project.new.check
        end

        it "fails if the project is invalid" do
          config.update(api_token: "valid token", default_project: "invalid ID")
          output = "The object you tried to access could not be found...\n\n"
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end
      end

      describe '#reset' do
        it "resets the default project" do
          config.update(default_project: "project")
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
            config.update(api_token: "invalid token")
            expect(STDOUT).to receive(:puts).with output
            Project.new.set "valid ID"
            expect(config.default_project).to eq nil
          end
        end

        describe '#check' do
          it "fails" do
            config.update(api_token: "invalid token", default_project: "valid ID")
            expect(STDOUT).to receive(:puts).with output
            Project.new.check
          end
        end
      end

    end
  end
end
