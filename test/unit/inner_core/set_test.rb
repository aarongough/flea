require File.expand_path(File.join(File.dirname(__FILE__), '..', '..',  'test_helper.rb'))

class SetTest < Test::Unit::TestCase
  
  test "should add variable to environment" do
    env = Flea.run('
      (define test 2)
      (set! test 1)
    ')
    assert_equal(1, env[:test])
  end
  
end