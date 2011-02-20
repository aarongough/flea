require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Interpreter" do
    
    include Flea
   
    describe "#new" do
      it "should return an Interpreter" do
        Interpreter.new.should be_an Interpreter
      end
      
      it "should allow setting the base environment to use" do
        environment = mock("Environment")
        interpreter = Interpreter.new(:environment => environment)
        interpreter.base_environment.should be environment
      end
    end
    
    describe ".run" do
      it "should run a program in a clean environment and return the resulting environment" do
        environment = Interpreter.new.run("(define test 1)")
        environment.should be_an Environment
        environment.should have_variable :test
      end
    end
    
    describe ".eval" do
      before :each do
        @interpreter = Interpreter.new
      end
      
      context "with no environment supplied" do
        it "should interpret an integer literal and return the result" do
          result = @interpreter.eval("1")
          result.should == 1
        end
      end
      
      context "with supplied environment" do
        it "should interpret a symbol and return the value of the symbol" do
          environment = mock("Environment")
          environment.should_receive(:find).with(:test).and_return(1)
          result = @interpreter.eval("test", environment)
          result.should == 1
        end
      end
    end
    
  end
end