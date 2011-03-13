require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "quote" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should quote a list" do
      result = @interpreter.run('(quote (1 2 3))')
      result.should == [1, 2, 3]
    end
    
    it "should quote a single literal" do
      result = @interpreter.run('(quote 1)')
      result.should == 1
    end
    
  end
end