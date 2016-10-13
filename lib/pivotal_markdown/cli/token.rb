require "tracker_api"

module PivotalMarkdown
  module CLI
    class Token < Thor

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

      private

      def config
        @config ||= Config.new
      end

    end
  end
end
