require "tracker_api"

module PivotalMarkdown
  module CLI
    class Token < Thor

      desc "set TOKEN", "Set API token to access"
      def set(token)
        begin
          user = client(token).me
          config.api_token = token
          config.save
          puts "Token set for #{user.name} - #{user.email}."
        rescue
          raise Error.invalid_api_token
        end
      end

      desc "check", "Check configured API token"
      def check
        raise Error.no_api_token unless config.api_token
        begin
          user = client(config.api_token).me
          puts "Token set for #{user.name} - #{user.email}."
        rescue
          raise Error.invalid_api_token
        end
      end

      private

      def client(token)
        TrackerApi::Client.new(token: token)
      end

      def config
        @config ||= Config.new
      end

    end
  end
end
