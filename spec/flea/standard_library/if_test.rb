require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class IfTest < Test::Unit::TestCase
  
  test "should not execute consequent" do
    env = Flea.run('
      (define test 0)
      (if false
        (set! test 1))
    ')
    assert_equal(0, env[:test])
  end
  
  test "should execute consequent" do
    env = Flea.run('
      (define test 0)
      (if true
        (set! test 1))
    ')
    assert_equal(1, env[:test])
  end
  
  test "should execute alternative" do
    env = Flea.run('
      (define test 0)
      (if false
        (set! test 1)
        (set! test 2))
    ')
    assert_equal(2, env[:test])
  end
  
  test "should not execute alternative" do
    env = Flea.run('
      (define test 0)
      (if true
        (set! test 1)
        (set! test 2))
    ')
    assert_equal(1, env[:test])
  end
  
end