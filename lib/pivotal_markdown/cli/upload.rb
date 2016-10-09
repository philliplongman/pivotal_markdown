module PivotalMarkdown
  module CLI
    class Base < Thor
      include Shared

      desc "upload FILE", "Parse Markdown file into individual stories and upload stories to specified project"
      def stories(file)
        raise non_markdown_file_error unless file.end_with? ".md"
        MarkdownStory.parse_file(file).each(&:upload)
      end

    end
  end
end
