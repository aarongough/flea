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
          set! foo a)))
      
      (test 3)
    ')
    assert_equal 3, env[:foo]
  end
  
end