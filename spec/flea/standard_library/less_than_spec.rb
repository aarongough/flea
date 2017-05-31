require "spec_helper"

describe "Standard Library" do
  describe "less-than?" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "return true if it's first argument is smaller than all the others" do
      result = @interpreter.run('(less-than? 5 10 15 20)')
      result.should == true
    end
    
    it "return false if it's first argument is not smaller than all the others" do
      result = @interpreter.run('(less-than? 10 1 2 3 45)')
      result.should == false
    end
    
    it "should evaluate its arguments" do
      result = @interpreter.run('
        (define a 2)
        (define b 10)
        (less-than? b a a)
      ')
      result.should == false
    end
    
  end
end