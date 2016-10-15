module ConfigCleaner
  # Works like database_cleaner for the config file
  # Backs up ~/.pivotal_markdown before each test and restores it after.

  def backup_config_file
    if File.exist? config_file
      $backup = File.read config_file
      File.write(config_file, {}.to_yaml)
    end
  end

  def clean_config_file
    File.write(config_file, {}.to_yaml) if File.exist? config_file
  end

  def restore_config_file
    if $backup
      File.write(config_file, $backup)
    else
      FileUtils.remove config_file if File.exist? config_file
    end
  end

  private

  def config_file
    @config_file ||= File.join(Dir.home, ".pivotal_markdown")
  end
end
