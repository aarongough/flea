require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "list" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "should create a list from it's arguments" do
      result = @interpreter.run('(list 9 2 2)')
      expect(result).to be == [9, 2, 2]
    end

    it "should evaluate its arguments before creating the list" do
      result = @interpreter.run('
        (define a 2)
        (define b 9)
        (list b a a)
      ')
      expect(result).to be == [9, 2, 2]
    end

  end
end
