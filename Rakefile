require 'rubygems'
require 'any-spec'
require 'rspec/core/rake_task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "flea"
    gemspec.summary = "A tiny but flexible Lisp interpreter written in Ruby"
    gemspec.description = "Flea is an extremely simple, but extremely extensible Lisp interpreter written in Ruby."
    gemspec.email = "aaron@aarongough.com"
    gemspec.homepage = "http://github.com/aarongough/flea"
    gemspec.authors = ["Aaron Gough"]
    gemspec.rdoc_options << '--line-numbers' << '--inline-source'
    gemspec.extra_rdoc_files = ['README.rdoc', 'MIT-LICENSE']
    gemspec.add_dependency "sexpistol"
    gemspec.add_development_dependency "any-spec"
    gemspec.executables << 'flea'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

task :test => [:spec, :anyspec]

task :anyspec do
  test_runner = AnySpec::TestRunner.new("./bin/flea", "./flea-language-spec/flea-language-spec.yaml")
  test_runner.run_tests
end

desc "Run the specs for Flea"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = "-c"
  t.fail_on_error = false
  t.verbose = false
end