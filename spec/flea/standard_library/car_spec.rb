require "spec_helper"

describe "Standard Library" do
  describe "car" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should return first item of list" do
      result = @interpreter.run('
        (car (quote (10 2 2)))
      ')
      result.should == 10
    end
    
  end
end