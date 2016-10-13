require "spec_helper"

module PivotalMarkdown
  describe Verifier do

    before :each do
      allow(TrackerApi::Client).to receive(:new).with(token: "valid token") {
        DishonestClient.new
      }
      allow(TrackerApi::Client).to receive(:new).with(token: "invalid token") {
        raise FakeAuthenticationError.new
      }
    end

    describe '#name' do
      it "returns user's name" do
        verifier = Verifier.new("valid token")
        expect(verifier.name).to eq "Brigid O'Shaughnessy"
      end

      it "raises an error when API token is invalid" do
        verifier = Verifier.new("invalid token")
        expect { verifier.name }.to raise_error "Invalid API token."
      end
    end

    describe '#email' do
      it "returns user's email" do
        verifier = Verifier.new("valid token")
        expect(verifier.email).to eq "misswonderly@gmail.com"
      end

      it "raises an error when API token is invalid" do
        verifier = Verifier.new("invalid token")
        expect { verifier.email }.to raise_error "Invalid API token."
      end
    end

    describe '#project_name' do
      it "returns the default project's name" do
        verifier = Verifier.new("valid token", 'valid id')
        expect(verifier.project_name).to eq "Steal the Maltese Falcon"
      end

      it "raises an error when API token is invalid" do
        verifier = Verifier.new("invalid token", 'valid id')
        expect { verifier.project_name }.to raise_error "Invalid API token."
      end

      it "raises an error when project ID is invalid" do
        verifier = Verifier.new("valid token", 'invalid id')
        expect { verifier.project_name }.to raise_error "Project ID not found."
      end
    end

  end
end
