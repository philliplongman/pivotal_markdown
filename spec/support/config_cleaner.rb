module ConfigCleaner
  # Works like database_cleaner for the config file
  # Backs up ~/.pivotal_markdown before each test and restores it after.

  def backup_config
    FileUtils.remove backup_file if File.exist? backup_file

    FileUtils.move config_file, backup_file if File.exist? config_file
  end

  def restore_config
    FileUtils.remove config_file if File.exist? config_file

    FileUtils.move backup_file, config_file if File.exist? backup_file
  end

  private

  def config_file
    @config_file ||= File.join(Dir.home, ".pivotal_markdown")
  end

  def backup_file
    @backup_file ||= File.join(Dir.home, ".pivotal_markdown.backup")
  end
end
