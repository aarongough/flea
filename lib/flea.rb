$standard_library = ""

files = Dir[File.join(File.dirname(__FILE__), 'flea', 'outer_core', '*.rb')]
files.concat( Dir[File.join(File.dirname(__FILE__), 'flea', 'standard_library', '*.rb')])

files.each do |file|
  File.open(file) do |file|
    $standard_library << file.read + "\n"
  end
end

require "rubygems"
require "sexpistol"

require File.expand_path(File.join(File.dirname(__FILE__), "flea", "environment.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "flea", "core.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "flea", "interpreter.rb"))