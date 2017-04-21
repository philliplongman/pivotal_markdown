module PivotalMarkdown
  module CLI
    class Upload < Thor
      include Shared

      default_command :stories

      desc "FILE", "Parse Markdown file and upload stories to Pivotal Tracker"
      def stories(file=nil)
        return help unless file
        confirm_file_exists file
        confirm_file_is_markdown file
        check_config_for_api_token

        MarkdownStories.new(file).upload
      rescue => error
        output error_message(error)
      end

      private

      def confirm_file_exists(file)
        raise FileNotFoundError.new(file) unless File.exist?(file)
      end

      def confirm_file_is_markdown(file)
        raise MarkdownFormatError unless file.end_with?(".md")
      end

    end
  end
end
