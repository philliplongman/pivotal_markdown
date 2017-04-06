require "tracker_api"

module PivotalMarkdown
  module CLI
    class Project < Thor
      include Shared

      default_command :check

      desc "set PROJECT_ID", "Set default project"
      def set(id)
        if config.api_token
          project = client(config.api_token).project(id)
          config.update(default_project: id)
          puts "Default project set to (#{project.id}) #{project.name}.\n\n"
        else
          puts Message.no_api_token
        end
      rescue => error
        puts error_message error
      end

      desc "check", "Check configured default project"
      def check
        if config.api_token && config.default_project
          project = client(config.api_token).project(config.default_project)
          puts "Default project set to (#{project.id}) #{project.name}.\n\n"

        elsif config.api_token.nil?
          puts Message.no_api_token

        elsif config.default_project.nil?
          puts Message.no_default_project
        end
      rescue => error
        puts error_message error
      end

      desc "reset", "Clear configured API token"
      def reset
        config.update(default_project: nil)
        puts "Default project reset.\n\n"
      end

    end
  end
end
