module PivotalMarkdown
  class Error < StandardError

    def response
      { body: { "error" => self.to_s } }
    end

  end
end

require_relative "errors/file_not_found_error"
require_relative "errors/markdown_format_error"
require_relative "errors/no_project_error"
require_relative "errors/no_token_error"
