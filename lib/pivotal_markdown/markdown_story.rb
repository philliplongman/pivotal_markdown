module PivotalMarkdown
  class MarkdownStory

    def initialize(project, markdown_block="")
      @name, @description, @labels, @tasks = "", "", [], []
      @project = project
      parse_block markdown_block
    end

    def upload
      story = create_story
      tasks.each { |task| story.tasks.create(description: task) }
      puts output_name
    end

    private

    attr_accessor :project, :name, :story_type, :description, :labels, :tasks

    def parse_block(markdown_block)
      markdown_block.each_line do |line|
        case line
        when /^# /
          @name = line.chomp.gsub("# ", "")
          @story_type = story_type_from_name
        when /^Labels: /
          @labels = line.chomp.gsub("Labels: ", "").split(', ')
        when /^- /
          @tasks << line.chomp.gsub("- ", "")
        else
          @description << line
        end
      end
      description.strip!
    end

    def story_type_from_name
      case name
      when /\(feature\)$/, /\(chore\)$/, /\(bug\)$/
        name.slice!(/ \(.+\)$/).gsub(" (", "").gsub(")", "")
      else
        "feature"
      end
    end

    def create_story
      project.stories.create(
        name:         name,
        story_type:   story_type,
        description:  description,
        labels:       labels.join(", ")
      )
    end

    def output_name
      if story_type == "feature"
        "  #{name}"
      else
        "  #{name} (#{story_type})"
      end
    end

  end
end
