require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Environment" do
    
    include Flea
    
    describe ".new" do
      it "should return an environment object" do
        Environment.new.should be_an Environment
      end
      
      it "should return an environment object with no parent" do
        environment = Environment.new
        environment.parent.should be_nil
      end
      
      it "should return an environment object with the specified parent" do
        parent_environment = mock("Environment")
        environment = Environment.new(parent_environment)
        environment.parent.should be parent_environment
      end
    end
    
    describe "#has_variable?" do
      context "without a parent" do
        before :each do
          @environment = Environment.new
        end
        
        it "should return false if the variable is not set in the current environment" do
          @environment.should_not have_variable :test
        end
        
        it "should return true if the variable is set in the current environment" do
          @environment.define(:test, 1)
          @environment.should have_variable :test
        end
      end
      
      context "with a parent" do
        before :each do
          @parent_environment = Environment.new
          @environment = Environment.new(@parent_environment)
        end
        
        it "should return false if the variable is not set in the parent environment" do
          @environment.should_not have_variable :test
        end
        
        it "should return true if the variable is set in the parent environment" do
          @parent_environment.define(:test, 1)
          @environment.should have_variable :test
        end
      end
    end
    
    describe "#define" do
      it "should set a variable to the supplied value" do
        env = Environment.new
        env.define(:test, 1)
        env.should have_variable :test
        env.find(:test).should == 1
      end
    end
    
    describe "#find" do
      context "without a parent" do
        before :each do
          @environment = Environment.new
          @environment.define(:test, 1)
        end
        
        it "should find a variable in the current environment" do
          @environment.find(:test).should == 1
        end
        
        it "should return nil when variable is not set" do
          @environment.find(:fake).should be_nil
        end
      end
      
      context "with a parent" do
        before :each do
          @parent_environment = Environment.new
          @environment = Environment.new(@parent_environment)
          @parent_environment.define(:test, 1)
        end
        
        it "should find a variable in the parent environment" do
          @environment.find(:test).should == 1
        end
        
        it "should return a variable from the current environment if it is set in both current and parent" do
          @environment.define(:test, 5)
          @environment.find(:test).should == 5
        end
        
        it "should return nil when variable is not set in the current or parent environment" do
          @environment.find(:fake).should be_nil
        end
      end
    end
  end
end