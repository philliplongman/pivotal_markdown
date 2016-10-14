require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Project do

      let(:config) { Config.new }

      before :each do
        backup_config
        stub_pivotal_tracker_api
      end

      after :each do
        restore_config
      end

      describe '#set' do

        it "verifies the project" do
          config.api_token = "valid token"
          config.save

          valid_id = "00000"
          readout = "Default project set to (00000) Steal the Maltese Falcon."
          expect(STDOUT).to receive(:puts).with(readout)
          Project.new.set valid_id
        end

        it "records the project in the config file" do
          config.api_token = "valid token"
          config.save

          valid_id = "00000"
          Project.new.set valid_id
          expect(config.default_project).to eq valid_id
        end

        it "raises an error if there is no stored API token" do
          error = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect { Project.new.set "valid ID" }.to raise_error error
        end
      end

      describe '#check' do
        it "displays the stored project" do
          valid_id = "00000"

          config.api_token = "valid token"
          config.default_project = valid_id
          config.save

          readout = "Default project set to (00000) Steal the Maltese Falcon."
          expect(STDOUT).to receive(:puts).with(readout)
          Project.new.check
        end

        it "raises an error if there is no stored API token" do
          error = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect { Project.new.check }.to raise_error error
        end

        it "raises an error if there is no default project stored" do
          config.api_token = "valid token"
          config.save

          error = "No default project set. Run `ptmd default --set ID` to set one."
          expect { Project.new.check }.to raise_error error
        end
      end

    end
  end
end
