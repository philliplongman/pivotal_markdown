module ConfigCleaner

  def backup_config
    FileUtils.move config_file, backup_file if File.exists? config_file
  end

  def restore_config
    FileUtils.remove config_file if File.exists? config_file

    FileUtils.move backup_file, config_file if File.exists? backup_file
  end

  private

  def config_file
    @config_file ||= File.join(Dir.home, ".pivotal_markdown")
  end

  def backup_file
    @backup_file ||= File.join(Dir.home, ".pivotal_markdown.backup")
  end
end
