module PivotalMarkdown
  module CLI
    class Upload < Thor
      include Shared

      default_command :stories

      desc "FILE", "Parse Markdown file and upload stories to Pivotal Tracker"
      def stories(file=nil)
        return help          unless file
        return no_file(file) unless File.exist?(file)
        return not_markdown  unless file.end_with?(".md")
        return no_api_token  unless config.api_token

        MarkdownStories.new(file).upload
      rescue => error
        puts error_message error
      end

      private

      def no_file(file)
        puts %(File not found #{file}\n\n)
      end

      def not_markdown
        puts Message.non_markdown_file
      end

      def no_api_token
        puts Message.no_api_token
      end

    end
  end
end
