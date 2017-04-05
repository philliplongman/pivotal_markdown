require 'ostruct'

module Mocks

  class FakePivotalTrackerProject

    attr_reader :project

    def initialize(project)
      @project = project
    end

    def stories

    end

  end

end
