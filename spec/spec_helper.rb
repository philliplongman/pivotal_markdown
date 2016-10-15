$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'support/fraudulent_objects'

include ConfigCleaner
include FraudulentObjects

require 'coveralls'
Coveralls.wear!


RSpec.configure do |config|

  config.before :each do
    backup_config

    # Mock API calls to Pivotal Tracker
    allow(TrackerApi::Client).to receive(:new) { |arg| DishonestClient.new(arg) }

    # Return puts output as a string to keep it out of the terminal
    allow(STDOUT).to receive(:puts)
  end

  config.after :each do
    restore_config
  end

end
