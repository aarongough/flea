require "spec_helper"

describe "Standard Library" do
  describe "greater-than?" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "return true if it's first argument is larger than all the others" do
      result = @interpreter.run('(greater-than? 10 1 2 3 4)')
      expect(result).to be true
    end
    
    it "return false if it's first argument is not larger than all the others" do
      result = @interpreter.run('(greater-than? 10 1 2 3 45)')
      expect(result).to be false
    end
    
    it "should evaluate its arguments" do
      result = @interpreter.run('
        (define a 2)
        (define b 10)
        (greater-than? b a a)
      ')
      
      expect(result).to be true
    end
    
  end
end