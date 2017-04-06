module PivotalMarkdown
  class MarkdownStories

    PivotalTracker::Client.token = Config.new.api_token

    attr_reader :project, :stories

    def initialize(markdown_file)
      @story_blocks = File.read(markdown_file).split(/^(?=[#])/)
      @project = get_project
      @stories = story_blocks.map { |block| MarkdownStory.new(project, block) }
    end

    def upload
      puts "(#{project.id}) #{project.name}"
      stories.each(&:upload)
      puts "\n"
    end

    private

    attr_accessor :story_blocks

    def get_project
      if project_id.present?
        PivotalTracker::Project.find project_id
      else
        puts "No project specified in file."
        puts Message.no_default_project
        exit
      end
    end

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
