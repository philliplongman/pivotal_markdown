module PivotalMarkdown
  class NoTokenError < Error

    def to_s
      "No API token saved. Run `ptmd api --set TOKEN` to set one."
    end

  end
end
