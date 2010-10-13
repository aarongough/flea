require File.expand_path(File.join(File.dirname(__FILE__), '..', '..',  'test_helper.rb'))

class SetTest < Test::Unit::TestCase
  
  test "should assign value to  variable" do
    env = Flea.run('
      (define test 2)
      (set! test 1)
    ')
    assert_equal(1, env[:test])
  end
  
  test "should raise error when attempting to set unbound variable" do
    assert_raises Exception do
      Flea.run('
        (set! blah 1)
      ')
    end
  end
  
end