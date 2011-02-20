require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Environment" do
    
    include Flea
    
    describe ".new" do
      it "should return an environment object"
      it "should return a environment object with no parent"
      it "should return a environment object with the specified parent"
      it "should"
    end
    
    describe "#has_variable?" do
      context "without a parent" do
        it "should return false if the variable is not set in the current environment"
        it "should return true if the variable is set in the current environment"
      end
      
      context "with a parent" do
        it "should return false if the variable is not set in the parent environment"
        it "should return true if the variable is set in the parent environment"
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
        it "should find a variable in the current environment"
        it "should return nil when variable is not set"
      end
      
      context "with a parent" do
        it "should find a variable in the current environment"
        it "should find a variable in the parent environment"
        it "should return nil when variable is not set in the current or parent environment"
      end
    end
  end
end