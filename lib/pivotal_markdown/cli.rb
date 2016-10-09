require "thor"

module PivotalMarkdown
  class CLI < Thor
    desc "api", "check or set api token"
    option :set
    def api
      if options[:set]
        config.api_token = options[:set]
        config.save!
        puts "Token set to #{config.api_token}"
      elsif config.api_token
        puts "API Token: #{config.api_token}"
      else
        puts no_api_token_message
      end
    end

    private

    def config
      @config ||= Config.new
    end

    def no_api_token_message
      "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end
  end
end
