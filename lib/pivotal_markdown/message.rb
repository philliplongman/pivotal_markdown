module PivotalMarkdown
  class Message

    class << self

      def invalid_api_token
        "Invalid API token."
      end

      def invalid_project_id
        "Project ID not found."
      end

      def non_markdown_file
        "File must be in Markdown format. " +
        'See "https://github.com/philliplongman/pivotal_markdown" for more information.'
      end

      def no_api_token
        "No API token saved. Run `ptmd api --set TOKEN` to set one."
      end

      def no_default_project
        "No default project set. Run `ptmd default --set ID` to set one."
      end

    end

  end
end
