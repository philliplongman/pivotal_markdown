require "tracker_api"

module PivotalMarkdown
  module CLI
    class Project < Thor
      include Shared

      default_command :check

      desc "set PROJECT_ID", "Set default project"
      def set(id)
        check_config_for_api_token
        project = client(config.api_token).project(id)
        config.update(default_project: id)
        puts "Default project set to (#{project.id}) #{project.name}.\n\n"
      rescue => error
        output error_message(error)
      end

      desc "check", "Check configured default project"
      def check
        check_config_for_api_token
        check_config_for_default_project
        project = client(config.api_token).project(config.default_project)
        puts "Default project set to (#{project.id}) #{project.name}.\n\n"
      rescue => error
        output error_message(error)
      end

      desc "reset", "Clear configured API token"
      def reset
        config.update(default_project: nil)
        puts "Default project reset.\n\n"
      end

    end
  end
end
