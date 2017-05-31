require "spec_helper"

describe "Standard Library" do
  describe "division operator" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should divide several integers" do
      result = @interpreter.run('(/ 10 2 2)')
      result.should == 2
    end
    
    it "should divide several floats" do
      result = @interpreter.run('(/ 10.0 2 2)')
      result.should == 2.5
    end
    
    it "should evaluate its arguments before dividing them" do
      result = @interpreter.run('
        (define a 2)
        (define b 10)
        (/ b a a)
      ')
      result.should == 2
    end
    
  end
end