module PivotalMarkdown
  class MarkdownStories

    PivotalTracker::Client.token = Config.new.api_token

    attr_reader :project, :stories

    def initialize(markdown_file)
      @story_blocks = File.read(markdown_file).split(/^(?=[#])/)
      if project_id
        @project = PivotalTracker::Project.find project_id
      else
        puts "No project specified in file."
        raise NoProjectError
      end
      @stories = story_blocks.map { |block| MarkdownStory.new(project, block) }
    end

    def upload
      puts "(#{project.id}) #{project.name}"
      puts stories.map(&:upload)
      puts
    end

    private

    attr_accessor :story_blocks

    def project_id
      @project_id ||= (id_from_file || Config.new.default_project || nil)
    end

    def id_from_file
      if story_blocks.first.start_with? "Project:"
        story_blocks.shift.match(/\d+/).to_s
      end
    end

  end
end
