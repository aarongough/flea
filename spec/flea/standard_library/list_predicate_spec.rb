require "spec_helper"

describe "Standard Library" do
  describe "list?" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should should return true for an empty list" do
      result = @interpreter.run("(list? '())")
      result.should == true
    end
    
    it "return true for a populated list" do
      result = @interpreter.run("(list? '(a b c))")
      result.should == true
    end
    
    it "should return false for an atom" do
      result = @interpreter.run("(list? 'a)")
      result.should == false
    end
    
  end
end