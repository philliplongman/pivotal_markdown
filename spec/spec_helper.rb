$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'support/fraudulent_objects'

include ConfigCleaner
include FraudulentObjects

require 'coveralls'
Coveralls.wear!


RSpec.configure do |config|

  config.before :suite do
    backup_config_file
  end

  config.before :each do
    clean_config_file

    # Mock API calls to Pivotal Tracker
    allow(TrackerApi::Client).to receive(:new) { |arg| DishonestClient.new(arg) }

    # Keep stdout from the gem out of the test output.
    allow(STDOUT).to receive(:puts)
  end

  config.after :suite do
    restore_config_file
  end

end
