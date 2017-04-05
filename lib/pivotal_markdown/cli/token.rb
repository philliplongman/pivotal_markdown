require "tracker_api"

module PivotalMarkdown
  module CLI
    class Token < Thor
      include Shared

      default_command :check

      desc "set TOKEN", "Set API token to access"
      def set(token)
        user = client(token).me
        config.api_token = token
        config.save
        puts "Token set for #{user.name} - #{user.email}.\n\n"
      rescue => error
        puts error_message error
      end

      desc "check", "Check configured API token"
      def check
        if config.api_token
          user = client(config.api_token).me
          puts "Token set for #{user.name} - #{user.email}.\n\n"
        else
          puts Message.no_api_token
        end
      rescue => error
        puts error_message error
      end

    end
  end
end
