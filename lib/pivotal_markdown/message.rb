module PivotalMarkdown
  class Message

    class << self

      def non_markdown_file
        url = %q("https://github.com/philliplongman/pivotal_markdown")
        "File must be in Markdown format.\n" +
        "See #{url} for more information."
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
