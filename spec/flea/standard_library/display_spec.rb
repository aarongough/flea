require "spec_helper"

describe "Standard Library" do
  describe "display" do
    before :each do
      @interpreter = Flea::Interpreter.new
      @old_stdout = $stdout
      @buffer = StringIO.new
      $stdout = @buffer
    end
    
    it "should output simple literal" do
      @interpreter.run('(display 1)')
      @buffer.string.should == "1"
    end
    
    it "should output a list" do
      @interpreter.run('(display (quote (1 2 3)))')
      @buffer.string.should == "(1 2 3)"
    end
    
    it "should output true and false using Scheme external representation" do
      @interpreter.run('(display #t)(display #f)')
      @buffer.string.should == "#t#f"
    end
    
    it "should return the same value that it displayed" do
      result = @interpreter.run('(display "abc")')
      result.should == "abc"
    end
    
    after :each do
      $stdout = @old_stdout
    end
  end
end