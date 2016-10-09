module PivotalMarkdown
  class CLI < Thor

    desc "upload FILE", "Parse Markdown file into individual stories and upload them"
    def upload(file)
      raise non_markdown_file_error unless file.end_with? ".md"
      MarkdownStory.parse_file(file).each(&:upload)
    end

    private

    def non_markdown_file_error
      StandardError.new "File must be in Markdown format. " +
        'See "https://github.com/philliplongman/pivotal_markdown" for more information.'
    end

  end
end
