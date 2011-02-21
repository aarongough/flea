require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "set!" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should change the value of an existing variable" do
      @interpreter.run('
        (define test 1)
        (set! test 2)')
      @interpreter.base_environment.find(:test).should == 2
    end
    
    it "should raise error when attempting to set unbound variable" do
      lambda {
        @interpreter.run('(set! test 1)')
      }.should raise_error
    end
    
  end
end