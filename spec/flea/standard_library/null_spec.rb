require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "null?" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
  
    it "should return true for an empty list" do
      result = @interpreter.run('
        (null? \'())
      ')
      result.should == true
    end
    
    ["1", '"abc"', "(1 2 3)"].each do |value|
      it "should return false for #{value}" do
        result = @interpreter.run("
          (null? (quote #{value}))
        ")
        result.should == false
      end
    end
    
  end
end