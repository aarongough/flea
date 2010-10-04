Dir[File.join(File.dirname(__FILE__), 'flea', 'standard_library', '*.rb')].each {|file| require File.expand_path(file) }

require "rubygems"
require "sexpistol"

require File.expand_path(File.join(File.dirname(__FILE__), "flea", "flea_environment.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "flea", "flea.rb"))