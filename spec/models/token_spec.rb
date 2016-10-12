require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Token do

      let(:config) { Config.new }

      before :each do
        backup_config

        unreliable_user_info = double(
          name: "Holden Caulfield", email: "catcher@therye.com"
        )
        allow(Verifier).to receive(:new) { unreliable_user_info }
      end

      after :each do
        restore_config
      end

      describe '#set' do
        it "verifies the token" do
          readout = "Token set for Holden Caulfield - catcher@therye.com."
          expect(STDOUT).to receive(:puts).with(readout)
          Token.new.set "valid API token"
        end

        it "records the token in the config file" do
          Token.new.set "valid API token"
          expect(config.api_token).to eq "valid API token"
        end
      end

      describe '#check' do
        it "displays the stored token" do
          config.api_token = "valid API token"
          config.save

          readout = "Token set for Holden Caulfield - catcher@therye.com."
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
