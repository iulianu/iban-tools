$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'iban-tools'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
