require "tracker_api"

module PivotalMarkdown
  module CLI
    class Token < Thor
      include Shared

      desc "set TOKEN", "Set API token to access"
      def set(token)
        verifier = Verifier.new(token)
        puts "Token set for #{verifier.name} - #{verifier.email}."
        config.api_token = token
        config.save
      end

      desc "check", "Check configured API token"
      def check
        raise Error.no_api_token unless config.api_token

        verifier = Verifier.new(config.api_token)
        puts "Token set for #{verifier.name} - #{verifier.email}."
      end

    end
  end
end
