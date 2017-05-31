require "spec_helper"

describe "Standard Library" do
  describe "read" do
    before :each do
      @interpreter = Flea::Interpreter.new
      @old_stdin = $stdin
      @buffer = StringIO.new
      $stdin = @buffer
    end
    
    it "should read data structure from STDIN" do
      @buffer.string = "(1 2.0 test (1 2 3))\n"
      result = @interpreter.run('(read)')
      result.should == [[1, 2.0, :test, [1, 2, 3]]]
    end
    
    after :each do
      $stdin = @old_stdin
    end
    
  end
end