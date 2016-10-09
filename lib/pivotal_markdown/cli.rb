require "thor"
require "tracker_api"

module PivotalMarkdown
  class CLI < Thor
    desc "api [--set <API token>]", "check or set <API token>"
    option :set
    def api
      if options[:set]
        set_api_token options[:set]

      elsif config.api_token
        retrieve_api_user config.api_token

      else
        puts no_api_token_message
      end
    end

    private

    def config
      @config ||= Config.new
    end

    def set_api_token(token)
      verifier = Verifier.new(token)
      if verifier.valid_token?
        config.api_token = token
        config.save!
        puts "Token set for #{verifier.name} - #{verifier.email}"
      else
        puts invalid_api_token_message
      end
    end

    def retrieve_api_user(token)
      verifier = Verifier.new(token)
      if verifier.valid_token?
        puts "Token set for #{verifier.name} - #{verifier.email}"
      else
        puts invalid_api_token_message
      end
    end

    def no_api_token_message
      "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end

    def invalid_api_token_message
      "Invalid API token."
    end
  end
end
