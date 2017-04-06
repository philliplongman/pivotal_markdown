require 'ostruct'

module Mocks

  class FakePivotalTrackerProject
    attr_reader :id, :token, :name, :stories

    def initialize(id)
      @id = id
      @token = PivotalMarkdown::Config.new.api_token
      @name = "Steal the Maltese Falcon"
      @stories = FakePivotalTrackerStories.new

      raise_errors_for_invalid_configs
    end

    def raise_errors_for_invalid_configs
      raise InvalidTokenError.new if token == "invalid token"
      raise InvalidProjectError.new if id == "invalid ID"
    end
  end

  class FakePivotalTrackerStories
    def create(**options)
      FakePivotalTrackerStory.new
    end
  end

  class FakePivotalTrackerStory
    attr_reader :tasks

    def initialize
      @tasks = FakePivotalTrackerTasks.new
    end
  end

  class FakePivotalTrackerTasks
    def create(description:)
    end
  end

end
