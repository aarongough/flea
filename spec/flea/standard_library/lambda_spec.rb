require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "lambda" do
    before :each do
      @interpreter = Flea::Interpreter.new
      @old_stdout = $stdout
      @buffer = StringIO.new
      $stdout = @buffer
    end
    
    after :each do
      $stdout = @old_stdout
    end
    
    it "should create a lambda that takes no arguments" do
      result = @interpreter.run('
        (lambda () ())
      ')
      result.should be_a Proc
    end

    it "should create and execute a lambda that takes no arguments" do
      result = @interpreter.run('
        ((lambda () 
          (display 1)))
      ')
      result.should == 1
    end
    
    it "should create a lambda that takes a single argument" do
      result = @interpreter.run('
        (lambda a ())
      ')
      result.should be_a Proc
    end
    
    it "should take list as single argument" do
      result = @interpreter.run('
        ((lambda a
          (display a)) 1 2 3)
      ')
      result.should == [1, 2, 3]
    end
    
    it "should create a lambda that takes multiple arguments" do
      result = @interpreter.run('
        (lambda (a b c) ())
      ')
      result.should be_a Proc
    end
    
    it "should create aand execute a lambda that takes multiple arguments" do
      result = @interpreter.run('
        ((lambda (a b c)
          (display a b c)) (1 2 3))
      ')
      result.should == [1, 2, 3]
    end
    
    it "should raise an error when lamda is defined using same argument name more than once" do
      lambda {
        @interpreter.run('
          (lambda (a a a) ())
        ')
      }.should raise_error
    end
    
  end
end
  
#  
#  test "lamda should take n-or-more arguments" do
#    env = Flea.run('
#      (define x 0)
#      (define y 0)
#      (define z 0)
#      (define list_arg 0)
#      ((lambda (a b c . d) (
#        begin
#          (set! x a)
#          (set! y b)
#          (set! z c)
#          (set! list_arg d))) 1 2 3 4 5 6 7)
#    ')
#    assert_equal [4,5,6,7], env[:list_arg]
#    assert_equal 1, env[:x]
#    assert_equal 2, env[:y]
#    assert_equal 3, env[:z]
#  end
#  
#  test "lambda in lambda" do
#    env = Flea.run('
#      (define a 0)
#      (define b 0)
#      (define test 
#        (lambda (x y) 
#          ((lambda ()
#            (set! a x)
#            (set! b y)))))
#          
#      (test 1 2)
#    ')
#    assert_equal 1, env[:a]
#    assert_equal 2, env[:b]
#  end
#  
#  test "if lambda body is a list, each item should be executed and the last result should be returned" do
#    env = Flea.run('
#      (define a 0)
#      (define b 0)
#      (define test 
#        (lambda (x y) 
#          (set! a x)
#          (set! b y)
#          (+ x y)))
#          
#      (define c (test 1 2))
#    ')
#    assert_equal 1, env[:a]
#    assert_equal 2, env[:b]
#    assert_equal 3, env[:c]
#  end
#  
#end