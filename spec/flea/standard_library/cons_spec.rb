require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "cons" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "should create a list from an atom and an empty list" do
      result = @interpreter.run("(cons 'a '())")
      expect(result).to be == [:a]
    end

    it "should create a list from a pair of lists" do
      result = @interpreter.run("(cons '(a) '(b c d))")
      expect(result).to be == [[:a], :b, :c, :d]
    end

    it "should push an atom on an existing list" do
      result = @interpreter.run('(cons "a" \'(b c ))')
      expect(result).to be == ["a", :b, :c]
    end

  end
end
