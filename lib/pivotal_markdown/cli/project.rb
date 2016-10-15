require "tracker_api"

module PivotalMarkdown
  module CLI
    class Project < Thor
      include Shared

      desc "set PROJECT_ID", "Set default project"
      def set(id)
        if config.api_token
          project = client(config.api_token).project(id)
          config.default_project = id
          config.save
          puts "Default project set to (#{project.id}) #{project.name}."
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
          puts "Default project set to (#{project.id}) #{project.name}."

        elsif config.api_token.nil?
          puts Message.no_api_token

        elsif config.default_project.nil?
          puts Message.no_default_project
        end
      rescue => error
        puts error_message error
      end

    end
  end
end
