require "tracker_api"

module PivotalMarkdown
  class Verifier

    def initialize(api_token)
      @api_token = api_token
    end

    def name
      me.name
    end

    def email
      me.email
    end

    private

    attr_reader :api_token

    def me
      @me ||= begin
        client.me
      rescue
        raise StandardError.new "Invalid API token."
      end
    end

    def client
      TrackerApi::Client.new(token: api_token)
    end

  end
end
