require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class IfTest < Test::Unit::TestCase
  
  test "should define test to 1" do
    env = Flea.run('
      (if false
        (define test 1))
    ')
    assert_equal(nil, env[:test])
  end
  
end