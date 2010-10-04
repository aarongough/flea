require File.expand_path(File.join(File.dirname(__FILE__), '..', '..',  'test_helper.rb'))

class ParseAndRunTest < Test::Unit::TestCase
  
  test "should parse a string and run the resulting program" do
    env = Flea.parse_and_run("(define test 1)")
    assert_equal(1, env[:test])
  end
  
end