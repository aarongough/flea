require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "subtraction operator" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "should subtract several numbers" do
      result = @interpreter.run('(- 9 2 2)')
      expect(result).to be == 5
    end

    it "should evaluate its arguments before subtracting them" do
      result = @interpreter.run('
        (define a 2)
        (define b 9)
        (- b a a)
      ')
      expect(result).to be == 5
    end

  end
end
