require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class OperatorTest < Test::Unit::TestCase
  
  test "addition" do
    env = Flea.run('
      (define test (+ 2 2 2))
    ')
    assert_equal(6, env[:test])
  end
  
  test "subtraction" do
    env = Flea.run('
      (define test (- 9 2 2))
    ')
    assert_equal(5, env[:test])
  end
  
  test "multiplication" do
    env = Flea.run('
      (define test (* 2 2 2))
    ')
    assert_equal(8, env[:test])
  end
  
  test "integer division" do
    env = Flea.run('
      (define test (/ 10 2 2))
    ')
    assert_equal(2, env[:test])
  end
  
  test "float division" do
    env = Flea.run('
      (define test (/ 10.0 2 2))
    ')
    assert_equal(2.5, env[:test])
  end
  
  test "equality (true)" do
    env = Flea.run('
      (define test (= 2 2 2))
    ')
    assert_equal(true, env[:test])
  end
  
  test "equality (false)" do
    env = Flea.run('
      (define test (= 4 2 2))
    ')
    assert_equal(false, env[:test])
  end
  
end