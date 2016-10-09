require "thor"
require "tracker_api"

require_relative "cli/config_commands"
require_relative "cli/story_commands"

module PivotalMarkdown
  class CLI < Thor

    private

    def no_api_token_error
      StandardError.new "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end

    def no_default_project_error
      StandardError.new "No default project set. Run `ptmd default --set ID` to set one."
    end

  end
end
