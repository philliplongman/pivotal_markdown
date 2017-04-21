module PivotalMarkdown
  class MarkdownFormatError < Error

    def to_s
      "File must be in Markdown format.\n" +
      'See "https://github.com/philliplongman/pivotal_markdown" for more information.'
    end

  end
end
