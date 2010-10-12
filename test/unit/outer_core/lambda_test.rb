require File.expand_path(File.join(File.dirname(__FILE__), '..', '..',  'test_helper.rb'))

class LambdaTest < Test::Unit::TestCase
  
  test "should create new lambda that does not take arguments" do
    env = Flea.run('
      (define foo 0)
      (define test 
        (lambda () (
          set! foo 1)))
    ')
    assert_kind_of Proc, env[:test]
  end
  
  test "should create and call new lambda without arguments" do
    env = Flea.run('
      (define foo 0)
      (define test 
        (lambda () (
          set! foo 1)))
      
      (test)
    ')
    assert_equal 1, env[:foo]
  end
  
  test "should create and call new lambda in place without arguments" do
    env = Flea.run('
      (define foo 0)
      ((lambda () (
          set! foo 3)))
    ')
    assert_equal 3, env[:foo]
  end
  
  test "should create new lambda that does take arguments" do
    env = Flea.run('
      (define foo 0)
      (define test 
        (lambda (a) (
          set! foo a)))
    ')
    assert_kind_of Proc, env[:test]
  end
  
  test "should create and call new lambda with arguments" do
    env = Flea.run('
      (define foo 0)
      (define test 
        (lambda (a) (
          set! foo (+ a a))))
      
      (test 3)
    ')
    assert_equal 6, env[:foo]
  end
  
  test "should create and call new lambda in place with arguments" do
    env = Flea.run('
      (define foo 0)
      ((lambda (a) (
          set! foo a)) 3)
    ')
    assert_equal 3, env[:foo]
  end
  
  test "should raise error when lambda is defined using same variable name multiple times in formals" do
    assert_raises Exception do
      env = Flea.run('
        (lambda (a a a) (
            set! foo a))
      ')
    end
  end
  
  test "lambda should take list as an argument" do
    env = Flea.run('
      (define foo 0)
      ((lambda a (
          set! foo a)) 1 2 3)
    ')
    assert_equal [1,2,3], env[:foo]
  end
  
  test "lamda should take n-or-more arguments" do
    env = Flea.run('
      (define x 0)
      (define y 0)
      (define z 0)
      (define list_arg 0)
      ((lambda (a b c . d) (
        begin
          (set! x a)
          (set! y b)
          (set! z c)
          (set! list_arg d))) 1 2 3 4 5 6 7)
    ')
    assert_equal [4,5,6,7], env[:list_arg]
    assert_equal 1, env[:x]
    assert_equal 2, env[:y]
    assert_equal 3, env[:z]
  end
  
  test "lambda in lambda" do
    env = Flea.run('
      (define a 0)
      (define b 0)
      (define test 
        (lambda (x y) 
          ((lambda ()
            (set! a x)
            (set! b y)))))
          
      (test 1 2)
    ')
    assert_equal 1, env[:a]
    assert_equal 2, env[:b]
  end
  
  test "if lambda body is a list, each item should be executed and the last result should be returned" do
    env = Flea.run('
      (define a 0)
      (define b 0)
      (define test 
        (lambda (x y) 
          (set! a x)
          (set! b y)
          (+ x y)))
          
      (define c (test 1 2))
    ')
    assert_equal 1, env[:a]
    assert_equal 2, env[:b]
    assert_equal 3, env[:c]
  end
  
end