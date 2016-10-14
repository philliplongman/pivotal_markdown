require "tracker_api"

module PivotalMarkdown
  module CLI
    class Project < Thor

      desc "set PROJECT_ID", "Set default project"
      def set(id)
        raise Error.no_api_token unless config.api_token
        begin
          project = client.project(id)
          config.default_project = id
          config.save
          puts "Default project set to (#{project.id}) #{project.name}."
        rescue => error
          error_handler error
        end
      end

      desc "check", "Check configured default project"
      def check
        raise Error.no_api_token unless config.api_token
        raise Error.no_default_project unless config.default_project
        begin
          project = client.project(config.default_project)
          puts "Default project set to (#{project.id}) #{project.name}."
        rescue => error
          error_handler error
        end
      end

      private

      def client
        TrackerApi::Client.new(token: config.api_token)
      end

      def config
        @config ||= Config.new
      end

      def error_handler(error)
        if error.response[:body]["code"] == "invalid_authentication"
          raise Error.invalid_api_token
        else
          raise Error.invalid_project_id
        end
      end

    end
  end
end
