$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pivotal_markdown'

require_relative 'support/config_cleaner'
require_relative 'support/fraudulent_objects'
require_relative 'support/spec_helper'

include ConfigCleaner
include FraudulentObjects
include SpecHelper

require 'coveralls'
Coveralls.wear!
