require 'rubygems'
require 'bundler/setup'
require 'detect_language'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.profile_examples = true
end
