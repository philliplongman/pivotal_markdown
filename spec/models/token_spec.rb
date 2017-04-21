require 'spec_helper'

module PivotalMarkdown
  module CLI

    describe Token do
      let(:config) { Config.new }

      describe '#set' do
        it "verifies the token" do
          output = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Token.new.set "valid token"
        end

        it "configures the token" do
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
        it "displays the configured token" do
          config.update(api_token: "valid token")
          output = "Token set for Brigid O'Shaughnessy - misswonderly@gmail.com.\n\n"
          expect(STDOUT).to receive(:puts).with output
          Token.new.check
        end

        it "gives instructions if there is no token configured" do
          expect(STDOUT).to receive(:puts).with NoTokenError.new.message
          Token.new.check
        end

        it "fails if the configured token is invalid" do
          config.update(api_token: "invalid token")
          output = "Invalid authentication credentials were presented."
          expect(STDOUT).to receive(:puts).with output
          Token.new.check
        end
      end

    end
  end
end
