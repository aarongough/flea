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
      expect(result).to be_a Proc
    end

    it "should create and execute a lambda that takes no arguments" do
      result = @interpreter.run('
        ((lambda ()
          (display 1)))
      ')
      expect(result).to be == 1
    end

    it "should create a lambda that takes a single argument" do
      result = @interpreter.run('
        (lambda a ())
      ')
      expect(result).to be_a Proc
    end

    it "should take list as single argument" do
      result = @interpreter.run('
        ((lambda a
          (display a)) 1 2 3)
      ')
      expect(result).to be == [1, 2, 3]
    end

    it "should create a lambda that takes multiple arguments" do
      result = @interpreter.run('
        (lambda (a b c) ())
      ')
      expect(result).to be_a Proc
    end

    it "should create aand execute a lambda that takes multiple arguments" do
      result = @interpreter.run('
        ((lambda (a b c)
          (display (+ a b c))) 1 2 3)
      ')
      expect(result).to be == 6
    end

    it "should raise an error when lamda is defined using same argument name more than once" do
      result = lambda {
        @interpreter.run('
          (lambda (a a a) ())
        ')
      }
      expect(result).to raise_error(RuntimeError)
    end

  end
end
