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

      def error_message(error)
        if error.response.nil?
          "No internet connection.\n\n"
        else
          error.response[:body]["error"] + "\n\n"
        end
      end

    end
  end
end
