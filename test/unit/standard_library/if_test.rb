require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class IfTest < Test::Unit::TestCase
  
  test "should not print 1" do
    env = Interpreter.new.run([[:begin, 
      [:set!, :test, 1],
      [:set!, :test, 2],
    ]])
    assert_equal(2, env[:test])
  end
  
end