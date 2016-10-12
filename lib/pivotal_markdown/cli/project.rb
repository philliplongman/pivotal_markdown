require "tracker_api"

module PivotalMarkdown
  module CLI
    class Project < Thor
      include Shared

      desc "set PROJECT_ID", "Set default project"
      def set(project_id)
        raise Error.no_api_token unless config.api_token

        verifier = Verifier.new(config.api_token, project_id)
        puts "Default project set to (#{verifier.project_id}) #{verifier.project_name}"
        config.default_project = project_id
        config.save
      end

      desc "check", "Check configured default project"
      def check
        raise Error.no_api_token unless config.api_token
        raise Error.no_default_project unless config.default_project

        verifier = Verifier.new(config.api_token, config.default_project)
        puts "Default project set to (#{verifier.project_id}) #{verifier.project_name}"
      end

    end
  end
end
