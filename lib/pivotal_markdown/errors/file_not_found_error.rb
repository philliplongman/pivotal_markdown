module PivotalMarkdown
  class FileNotFoundError < Error

    def initialize(file_path = nil, message = nil)
      super(message)
      @file_path = file_path
    end

    def to_s
      "File not found #{file_path}"
    end

    private

    attr_reader :file_path

  end
end
