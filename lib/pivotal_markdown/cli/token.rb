require "tracker_api"

module PivotalMarkdown
  module CLI
    class Token < Thor
      include Shared

      default_command :check

      desc "set TOKEN", "Set API token to access"
      def set(token)
        user = client(token).me
        config.update(api_token: token)
        output "Token set for #{user.name} - #{user.email}."
      rescue => error
        output error_message(error)
      end

      desc "check", "Check configured API token"
      def check
        check_config_for_api_token
        user = client(config.api_token).me
        output "Token set for #{user.name} - #{user.email}."
      rescue => error
        output error_message(error)
      end

    end
  end
end
