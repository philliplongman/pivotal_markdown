require "tracker_api"

module PivotalMarkdown
  module CLI
    module Shared

      private

      def client(token)
        TrackerApi::Client.new(token: token)
      end

      def config
        @config ||= Config.new
      end

      def check_config_for_api_token
        raise NoTokenError unless config.api_token
      end

      def check_config_for_default_project
        raise NoProjectError unless config.default_project
      end

      def output(message)
        puts message.to_s.chomp("")
        puts
      end

      def error_message(error)
        response = error.response
        if response.nil?
          "No response. Check internet connection."
        elsif response.respond_to? :body
          response.body
        else
          response[:body]["error"]
        end
      end

    end
  end
end
