require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Project do

      let(:config) { Config.new }

      before :each do
        backup_config
        allow(TrackerApi::Client).to receive(:new) { |arg| DishonestClient.new(arg) }
      end

      after :each do
        restore_config
      end

      describe '#set' do
        it "verifies the project" do
          config.api_token = "valid token"
          config.save

          valid_id = "00000"
          output = "Default project set to (00000) Steal the Maltese Falcon."
          expect(STDOUT).to receive(:puts).with output
          Project.new.set valid_id
        end

        it "records the project in the config file" do
          config.api_token = "valid token"
          config.save

          valid_id = "00000"
          Project.new.set valid_id
          expect(config.default_project).to eq valid_id
        end

        it "fails if the project is invalid" do
          config.api_token = "valid token"
          config.save

          output = "The object you tried to access could not be found..."
          expect(STDOUT).to receive(:puts).with output
          Project.new.set "invalid ID"
          expect(config.default_project).to eq nil
        end

        it "fails if there is no stored API token" do
          output = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect(STDOUT).to receive(:puts).with output
          Project.new.set "valid ID"
          expect(config.default_project).to eq nil
        end

        it "fails if the stored API token is invalid" do
          config.api_token = "invalid token"
          config.save

          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Project.new.set "valid ID"
          expect(config.default_project).to eq nil
        end
      end

      describe '#check' do
        it "displays the stored project" do
          valid_id = "00000"

          config.api_token = "valid token"
          config.default_project = valid_id
          config.save

          output = "Default project set to (00000) Steal the Maltese Falcon."
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "gives instructions if there is no default project stored" do
          config.api_token = "valid token"
          config.save

          output = "No default project set. Run `ptmd default --set ID` to set one."
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "fails if the project is invalid" do
          config.api_token = "valid token"
          config.default_project = "invalid ID"
          config.save

          output = "The object you tried to access could not be found..."
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "fails if there is no stored API token" do
          output = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end

        it "fails if the stored API token is invalid" do
          config.api_token = "invalid token"
          config.default_project = "invalid ID"
          config.save

          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Project.new.check
        end
      end

    end
  end
end
