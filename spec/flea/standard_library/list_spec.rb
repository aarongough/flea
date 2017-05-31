require "spec_helper"

describe "Standard Library" do
  describe "list" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should create a list from it's arguments" do
      result = @interpreter.run('(list 9 2 2)')
      result.should == [9, 2, 2]
    end
    
    it "should evaluate its arguments before creating the list" do
      result = @interpreter.run('
        (define a 2)
        (define b 9)
        (list b a a)
      ')
      result.should == [9, 2, 2]
    end
    
  end
end