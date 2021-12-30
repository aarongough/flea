require "spec_helper"

describe "Standard Library" do
  describe "string-to-num" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    it "should convert string to integer" do
      result = @interpreter.run('(string-to-num "10")')
      expect(result).to eq(10)
    end
    
    it "should convert string to float" do
      result = @interpreter.run('(string-to-num "23.0")')
      expect(result).to eq(23.0)
    end
    
    it "should evaluate its arguments" do
      result = @interpreter.run('
        (define a 2)
        (string-to-num a)
      ')

      expect(result).to eq(2)
    end
    
  end
end