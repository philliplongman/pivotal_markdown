require "tracker_api"

module PivotalMarkdown
  class Verifier

    def initialize(api_token)
      @api_token = api_token
    end

    def name
      @me.name if valid_token?
    end

    def email
      @me.email if valid_token?
    end

    def valid_token?
      me ? true : false
    end

    private

    attr_reader :api_token

    def me
      @me ||= begin
        client.me
      rescue
        false
      end
    end

    def client
      TrackerApi::Client.new(token: api_token)
    end

  end
end
