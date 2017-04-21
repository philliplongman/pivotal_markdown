module PivotalMarkdown
  class NoProjectError < Error

    def to_s
      "No default project set. Run `ptmd default --set ID` to set one."
    end

  end
end
