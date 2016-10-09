module PivotalMarkdown
  module CLI
    class Base < Thor

      desc "api COMMAND", "Configure API token to access Pivotal Tracker"
      subcommand 'api', Token

      desc "project COMMAND", "Configure project to default to when none is specified"
      subcommand 'project', Project

    end
  end
end
