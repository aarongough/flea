require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "list?" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "should should return true for an empty list" do
      result = @interpreter.run("(list? '())")
      expect(result).to be == true
    end

    it "return true for a populated list" do
      result = @interpreter.run("(list? '(a b c))")
      expect(result).to be == true
    end

    it "should return false for an atom" do
      result = @interpreter.run("(list? 'a)")
      expect(result).to be == false
    end

  end
end
