module PivotalMarkdown
  class Error

    class << self
      def invalid_api_token
        StandardError.new "Invalid API token."
      end

      def invalid_project_id
        StandardError.new "Project ID not found."
      end

      def non_markdown_file
        StandardError.new(
          "File must be in Markdown format. " +
          'See "https://github.com/philliplongman/pivotal_markdown" for more information.'
        )
      end

      def no_api_token
        StandardError.new "No API token saved. Run `ptmd api --set TOKEN` to set one."
      end

      def no_default_project
        StandardError.new "No default project set. Run `ptmd default --set ID` to set one."
      end
    end

  end
end
