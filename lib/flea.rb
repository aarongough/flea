Dir[File.join(File.dirname(__FILE__), 'flea', 'standard_library', '*.rb')].each {|file| require File.expand_path(file) }

require "flea/flea.rb"