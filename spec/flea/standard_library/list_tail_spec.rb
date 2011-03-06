require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "list-tail" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should return trailing subset of list" do
      result = @interpreter.run('
        (list-tail (quote (1 2 3 4 5)) 2)
      ')
      result.should == [3, 4, 5]
    end
    
  end
end