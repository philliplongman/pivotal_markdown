require "spec_helper"

module PivotalMarkdown
  describe Verifier do

    before :each do
      stub_pivotal_tracker_api
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
        valid_id = "00000"
        verifier = Verifier.new("valid token", valid_id)
        expect(verifier.project_name).to eq "Steal the Maltese Falcon"
      end

      it "raises an error when API token is invalid" do
        valid_id = "00000"
        verifier = Verifier.new("invalid token", valid_id)
        expect { verifier.project_name }.to raise_error "Invalid API token."
      end

      it "raises an error when project ID is invalid" do
        verifier = Verifier.new("valid token", 'invalid ID')
        expect { verifier.project_name }.to raise_error "Project ID not found."
      end
    end

  end
end
