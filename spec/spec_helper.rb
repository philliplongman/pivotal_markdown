$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'support/fraudulent_objects'
require_relative 'support/stfu'

include ConfigCleaner
include FraudulentObjects
include STFU

require 'coveralls'
Coveralls.wear!


RSpec.configure do |config|

  config.around :each do |example|
    stfu { example.run }
  end

end
