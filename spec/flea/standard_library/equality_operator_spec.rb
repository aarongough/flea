require "spec_helper"

describe "Standard Library" do
  describe "equality operator" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    context "for an expression that should evaluate to true" do
      it "should return the equality of several arguments" do
        result = @interpreter.run('
          (= 2 2 2)
        ')
        result.should == true
      end
      
      it "should evaluate its arguments before comparing them" do
        result = @interpreter.run('
          (define a 2)
          (= a a a)
        ')
        result.should == true
      end
    end
    
    context "for an expression that should evaluate to false" do
      it "should return the equality of several arguments" do
        result = @interpreter.run('
          (= 2 2 4)
        ')
        result.should == false
      end
      
      it "should evaluate its arguments before comparing them" do
        result = @interpreter.run('
          (define a 2)
          (define b 3)
          (= a a b)
        ')
        result.should == false
      end
    end
    
  end
end