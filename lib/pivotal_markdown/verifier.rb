require "tracker_api"

module PivotalMarkdown
  class Verifier

    attr_reader :project_id

    def initialize(api_token, project_id=nil)
      @api_token = api_token
      @project_id = project_id
    end

    def name
      me.name
    end

    def email
      me.email
    end

    def project_name
      project.name
    end

    private

    attr_reader :api_token

    def client
      TrackerApi::Client.new(token: api_token)
    end

    def me
      @me ||= begin
        client.me
      rescue
        raise StandardError.new "Invalid API token."
      end
    end

    def project
      @project ||= begin
        client.project project_id

      rescue => error
        if error.response[:body]["code"] == "invalid_authentication"
          raise StandardError.new "Invalid API token."
        else
          raise StandardError.new "Project ID not found."
        end
      end
    end

  end
end
