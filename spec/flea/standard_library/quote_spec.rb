require "spec_helper"

describe "Standard Library" do
  describe "quote" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should quote a list" do
      result = @interpreter.run('(quote (1 2 3))')
      expect(result).to eq([1, 2, 3])
    end
    
    it "should quote a single literal" do
      result = @interpreter.run('(quote 1)')
      expect(result).to eq(1)
    end
    
  end
end