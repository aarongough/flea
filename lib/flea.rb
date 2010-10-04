Dir[File.join(File.dirname(__FILE__), 'flea', 'standard_library', '*.rb')].each {|file| require File.expand_path(file) }

require "rubygems"
require "sexpistol"

require "flea/flea_environment.rb"
require "flea/flea.rb"