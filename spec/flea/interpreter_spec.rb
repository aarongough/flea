require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Interpreter" do
    
    include Flea
   
    describe "#new" do
      it "should return an Interpreter" do
        Interpreter.new.should be_an Interpreter
      end
      
      it "should allow setting the base environment to use" do
        environment = Flea::Environment.new
        interpreter = Interpreter.new(
          :base_environment => environment,
          :load_standard_library => false
        )
        interpreter.base_environment.should be environment
      end
    end
    
    describe ".run" do
      it "should run a program and return the last output from the program" do
        interpreter = Interpreter.new
        result = interpreter.run("(define test 1)")
        result.should == 1
        interpreter.base_environment.should have_variable :test
      end
    end
    
    describe ".parse" do
      it "should return an abstract syntax tree representing the supplied program" do
        ast = Interpreter.new.parse("(define test 1)")
        ast.should == [[:define, :test, 1]]
      end
    end
    
    describe ".evaluate" do
      before :each do
        @interpreter = Interpreter.new(
          :load_standard_library => false
        )
      end
      
      it "should return the value of a variable" do
        @interpreter.current_environment.define(:test, 1)
        result = @interpreter.evaluate(:test)
        result.should == 1
      end
      
      it "should define a variable in the current environment" do
        result = @interpreter.evaluate([:define, :test, 1])
        result.should == 1
      end
      
      it "should create a native function" do
        result = @interpreter.evaluate([:native_function, "
          Proc.new() do |arguments, interpreter|
            1
          end
        "])
        result.should be_a Proc
        result.call.should == 1        
      end
      
      it "should call a native function" do
        proc = Proc.new() do |arguments, interpreter|
          "bar"
        end
        @interpreter.current_environment.define(:foo, proc)
        result = @interpreter.evaluate([:foo, 1, 2, 3])
        result.should == "bar"
      end
      
      [1, 1.0, "string"].each do |literal|
        it "should return literal '#{literal}' as is" do
          result = @interpreter.evaluate(literal)
          result.should be literal
        end
      end
    end
    
  end
end