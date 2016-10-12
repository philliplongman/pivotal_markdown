require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Project do

      let(:config) { Config.new }

      before :each do
        backup_config

        untrustworthy_project_info = double(
          project_id: "000", project_name: "Help that Nigerian Prince"
        )
        allow(Verifier).to receive(:new) { untrustworthy_project_info }
      end

      after :each do
        restore_config
      end

      describe '#set' do

        it "verifies the project" do
          config.api_token = "valid API token"
          config.save

          readout = "Default project set to (000) Help that Nigerian Prince."
          expect(STDOUT).to receive(:puts).with(readout)
          Project.new.set "valid ID"
        end

        it "records the project in the config file" do
          config.api_token = "valid API token"
          config.save

          Project.new.set "valid ID"
          expect(config.default_project).to eq "valid ID"
        end

        it "raises an error if there is no stored API token" do
          error = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect { Project.new.set "valid ID" }.to raise_error error
        end
      end

      describe '#check' do
        it "displays the stored project" do
          config.api_token = "valid API token"
          config.default_project = "valid ID"
          config.save

          readout = "Default project set to (000) Help that Nigerian Prince."
          expect(STDOUT).to receive(:puts).with(readout)
          Project.new.check
        end

        it "raises an error if there is no stored API token" do
          error = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect { Project.new.check }.to raise_error error
        end

        it "raises an error if there is no default project stored" do
          config.api_token = "valid API token"
          config.save

          error = "No default project set. Run `ptmd default --set ID` to set one."
          expect { Project.new.check }.to raise_error error
        end
      end

    end
  end
end
