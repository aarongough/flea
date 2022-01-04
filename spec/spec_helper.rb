# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'

SimpleCov.start

require 'flea'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
end
