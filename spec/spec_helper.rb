require 'rubygems'
require 'rspec'
require 'stringio'

require_files = []
require_files << File.join(File.dirname(__FILE__), '..', 'lib',  'flea.rb')

require_files.each do |file|
  require File.expand_path(file)
end