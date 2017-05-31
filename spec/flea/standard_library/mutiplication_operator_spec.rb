require "spec_helper"

describe "Standard Library" do
  describe "multiplication operator" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should multiply several numbers" do
      result = @interpreter.run('(* 2 2 2)')
      result.should == 8
    end
    
    it "should evaluate its arguments before multiplying them" do
      result = @interpreter.run('
        (define a 2)
        (* a a a)
      ')
      result.should == 8
    end
    
  end
end