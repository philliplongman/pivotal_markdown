require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Token do

      let(:config) { Config.new }

      describe '#set' do
        it "verifies the token" do
          output = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com."
          expect(STDOUT).to receive(:puts).with output
          Token.new.set "valid token"
        end

        it "records the token in the config file" do
          Token.new.set "valid token"
          expect(config.api_token).to eq "valid token"
        end

        it "fails if the token is invalid" do
          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Token.new.set "invalid token"
          expect(config.api_token).to eq nil
        end
      end

      describe '#check' do
        it "displays the stored token" do
          config.api_token = "valid token"
          config.save

          output = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com."
          expect(STDOUT).to receive(:puts).with output
          Token.new.check
        end

        it "gives instructions if there is no stored token" do
          output = "No API token saved. Run `ptmd api --set TOKEN` to set one."
          expect(STDOUT).to receive(:puts).with output
          Token.new.check
        end

        it "fails if the stored token is invalid" do
          config.api_token = "invalid token"
          config.save

          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Token.new.check
        end
      end

    end
  end
end
