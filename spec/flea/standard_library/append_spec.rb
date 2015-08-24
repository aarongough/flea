require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "append" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "union of two lists" do
      result = @interpreter.run('
        (append (quote (1 2 3)) (quote (1 2 3)))
      ')
      expect(result).to be == [1, 2, 3, 1, 2, 3]
    end

  end
end
