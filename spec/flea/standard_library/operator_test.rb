require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class OperatorTest < Test::Unit::TestCase
  
  test "addition" do
    env = Flea.run('
      (define test (+ 2 2 2))
    ')
    assert_equal(6, env[:test])
  end
  
  test "addition should evaluate arguments" do
    env = Flea.run('
      (define a 2)
      (define test (+ a a a))
    ')
    assert_equal(6, env[:test])
  end
  
  test "subtraction" do
    env = Flea.run('
      (define test (- 9 2 2))
    ')
    assert_equal(5, env[:test])
  end
  
  test "subtraction should evaluate arguments" do
    env = Flea.run('
      (define a 2)
      (define b 9)
      (define test (- b a a))
    ')
    assert_equal(5, env[:test])
  end
  
  test "multiplication" do
    env = Flea.run('
      (define test (* 2 2 2))
    ')
    assert_equal(8, env[:test])
  end
  
  test "multiplication should evaluate arguments" do
    env = Flea.run('
      (define a 2)
      (define test (* a a a))
    ')
    assert_equal(8, env[:test])
  end
  
  test "integer division" do
    env = Flea.run('
      (define test (/ 10 2 2))
    ')
    assert_equal(2, env[:test])
  end
  
  test "division should evaluate arguments" do
    env = Flea.run('
      (define a 2)
      (define b 10)
      (define test (/ b a a))
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
      (define a 2)
      (define test (= a a a))
    ')
    assert_equal(true, env[:test])
  end
  
  test "equality (false)" do
    env = Flea.run('
      (define a 2)
      (define b 4)
      (define test (= b a a))
    ')
    assert_equal(false, env[:test])
  end
  
  test "equal? (true)" do
    env = Flea.run('
      (define a 2)
      (define test (= a a a))
    ')
    assert_equal(true, env[:test])
  end
  
  test "equal? (false)" do
    env = Flea.run('
      (define a 2)
      (define b 4)
      (define c 2)
      (define test (= b a c))
    ')
    assert_equal(false, env[:test])
  end
  
end