require "thor"
require "tracker_api"

module PivotalMarkdown
  class CLI < Thor

    desc "api [--set <API token>]", "check or set <API token>"
    option :set
    def api
      if options[:set]
        set_api_token(options[:set])
      else
        raise no_api_token_error unless config.api_token
        retrieve_api_user(config.api_token)
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

    def no_api_token_error
      StandardError.new "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end
  end
end
