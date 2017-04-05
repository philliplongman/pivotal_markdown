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

        MarkdownStory.parse_file(file).each(&:upload)
      rescue => error
        puts error
      end

      private

      def no_file(file)
        puts %(File not found "#{file}"\n\n)
        help
      end

      def not_markdown
        puts Message.non_markdown_file
      end

    end
  end
end
