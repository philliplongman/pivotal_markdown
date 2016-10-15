$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'support/fraudulent_objects'

include ConfigCleaner
include FraudulentObjects

require 'coveralls'
Coveralls.wear!
