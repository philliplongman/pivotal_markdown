require "thor"
require "tracker_api"

module PivotalMarkdown
  class CLI < Thor

    desc "api [--set TOKEN]", "check or set API token"
    option :set
    def api
      if options[:set]
        set_api_token options[:set]
      else
        raise no_api_token_error unless config.api_token
        retrieve_api_user config.api_token
      end
    end

    desc "default [--set ID]", "check or set default project ID"
    option :set
    def default
      raise no_api_token_error unless config.api_token

      if options[:set]
        set_default_project config.api_token, options[:set]
      else config.default_project
        raise no_default_project_error unless config.default_project
        retrieve_default_project(config.api_token, config.default_project)
      end
    end

    private

    def config
      @config ||= Config.new
    end

    def set_api_token(token)
      verifier = Verifier.new(token)
      puts "Token set for #{verifier.name} - #{verifier.email}"
      config.api_token = token
      config.save!
    end

    def retrieve_api_user(token)
      verifier = Verifier.new(token)
      puts "Token set for #{verifier.name} - #{verifier.email}"
    end

    def set_default_project(token, id)
      verifier = Verifier.new(token, id)
      puts "Default project set to (#{verifier.project_id}) #{verifier.project_name}"
      config.default_project = id
      config.save!
    end

    def retrieve_default_project(token, id)
      verifier = Verifier.new(token, id)
      puts "Default project set to (#{verifier.project_id}) #{verifier.project_name}"
    end

    def no_api_token_error
      StandardError.new "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end

    def no_default_project_error
      StandardError.new "No default project set. Run `ptmd default --set ID` to set one."
    end

  end
end
