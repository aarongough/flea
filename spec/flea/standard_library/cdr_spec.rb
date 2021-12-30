require "spec_helper"

describe "Standard Library" do
  describe "cdr" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should return remainder of list" do
      result = @interpreter.run('
        (cdr (quote (10 2 2)))
      ')

      expect(result).to eq([2, 2])
    end
    
  end
end