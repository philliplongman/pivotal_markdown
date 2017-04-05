require "yaml"

module PivotalMarkdown
  class Config

    def initialize
      File.write(config_file, {}.to_yaml) unless File.exist? config_file
    end

    def update(**options_hash)
      options_hash.each { |key, value| options[key.to_s] = value }
      save
    end

    def api_token
      options["api_token"]
    end

    def api_token=(token)
      options["api_token"] = token
    end

    def default_project
      options["default_project"]
    end

    def default_project=(id)
      options["default_project"] = id
    end

    def [](key)
      options[key]
    end

    def []=(key, input)
      options[key] = input
    end

    def save
      File.write(config_file, options.to_yaml)
      @options = nil  # "closes" the file
    end

    private

    def options
      @options ||= YAML.load(File.read config_file)
    end

    def config_file
      @config_file ||= File.join(Dir.home, ".pivotal_markdown")
    end
  end
end
