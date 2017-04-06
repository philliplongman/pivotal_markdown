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
        return "No response. Check internet connection.\n\n" if error.response.nil?
        binding.pry
        case error.class.to_s
        when "RestClient::Response" then error.response.body  + "\n\n"
        when "TrackerApi::Error"    then error.response[:body]["error"] + "\n\n"
        end
      end

      def error_message(error)
        response = error.response
        if response.nil?
          "No response. Check internet connection.\n\n"
        elsif response.respond_to? :body
          response.body  + "\n"
        else
          response[:body]["error"] + "\n\n"
        end
      end

    end
  end
end
