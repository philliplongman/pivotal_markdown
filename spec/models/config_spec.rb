require "spec_helper"

module PivotalMarkdown
  describe Config do

    let(:config_file) { File.join(Dir.home, ".pivotal_markdown") }

    describe '#initialize' do
      it "creates a new config file if none exists" do
        FileUtils.remove config_file if File.exist? config_file

        Config.new
        expect(File.exist? config_file).to be true

        contents = File.read config_file
        expect(contents).to eq "--- {}\n"
      end
    end

    describe '#update' do
      it "updates the options hash and calls #save" do
        config = Config.new
        config.update(taco: "pony")

        contents = File.read config_file
        expect(contents).to eq "---\ntaco: pony\n"
      end
    end

    describe '#save' do
      it "saves the options hash to config file" do
        config = Config.new
        config["Jesus saves"] = "He takes half damage"
        config.save

        contents = File.read config_file
        expect(contents).to eq "---\nJesus saves: He takes half damage\n"
      end

      it "resets the @options variable" do
        config = Config.new
        config.save
        expect(config.instance_variable_get :@options).to be nil
      end
    end

  end
end
