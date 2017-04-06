$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'mocks/tracker_api'
require_relative 'mocks/pivotal_tracker'

include ConfigCleaner
include Mocks

require 'coveralls'
Coveralls.wear!


RSpec.configure do |config|

  config.before :suite do
    backup_config_file
  end

  config.before :each do
    clean_config_file

    # Mock API calls to PivotalTracker from tracker_api gem
    allow(TrackerApi::Client).to receive(:new) do |arg|
      FakeTrackerApiClient.new(arg)
    end

    # Mock API calls to PivotalTracker from pivotal-tracker gem
    allow(PivotalTracker::Project).to receive(:find) do |arg|
      FakePivotalTrackerProject.new(arg)
    end

    # Keep stdout responses from the gem out of the test output.
    allow(STDOUT).to receive(:puts)
    allow(Kernel).to receive(:exit)
  end

  config.after :suite do
    restore_config_file
  end

end
