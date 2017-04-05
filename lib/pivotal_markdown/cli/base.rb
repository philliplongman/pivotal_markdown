module PivotalMarkdown
  module CLI
    class Base < Thor

      desc "api COMMAND", "Configure API token to access Pivotal Tracker"
      subcommand 'api', Token

      desc "project COMMAND", "Configure project to default to when none is specified"
      subcommand 'project', Project

      desc "[upload] FILE", "Parse Markdown file and upload stories to Pivotal Tracker"
      subcommand 'upload', Upload

    end
  end
end
