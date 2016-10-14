require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Token do

      let(:config) { Config.new }

      before :each do
        backup_config
        stub_pivotal_tracker_api
      end

      after :each do
        restore_config
      end

      describe '#set' do
        it "verifies the token" do
          readout = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com."
          expect(STDOUT).to receive(:puts).with(readout)
          Token.new.set "valid token"
        end

        it "records the token in the config file" do
          Token.new.set "valid token"
          expect(config.api_token).to eq "valid token"
        end
      end

      describe '#check' do
        it "displays the stored token" do
          config.api_token = "valid token"
          config.save

          readout = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com."
          expect(STDOUT).to receive(:puts).with(readout)
          Token.new.check
        end

        it "raises an error if there is no stored token" do
          error = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect { Token.new.check }.to raise_error error
        end
      end

    end
  end
end
