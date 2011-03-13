require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "gets" do
    before :each do
      @interpreter = Flea::Interpreter.new
      @old_stdin = $stdin
      @buffer = StringIO.new
      $stdin = @buffer
    end
    
    it "should get input from STDIN" do
      @buffer.string = "test\n"
      result = @interpreter.run('(gets)')
      result.should == "test\n"
    end
    
    after :each do
      $stdin = @old_stdin
    end
    
  end
end