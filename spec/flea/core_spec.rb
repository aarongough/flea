require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Core"

  include Flea
  
  describe ".create_native_function" do
    it "should return a Proc" do
      Core.create_native_function("").should be_a Proc
    end
    
    it "should return a Proc that expects two arguments" do
      Core.create_native_function("").arity.should == 3
    end
    
    it "should return a Proc that sets the local variable 'environment'" do
      native_function = Core.create_native_function("defined?(environment)")
      native_function.call(1,2,3).should be_true
    end
    
    it "should return a Proc that sets the local variable 'arguments'" do
      native_function = Core.create_native_function("defined?(arguments)")
      native_function.call(1,2,3).should be_true
    end
    
    it "should return a Proc that sets the local variable 'interpreter'" do
      native_function = Core.create_native_function("defined?(interpreter)")
      native_function.call(1,2,3).should be_true
    end
  end
  
end