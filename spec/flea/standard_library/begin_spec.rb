require File.dirname(__FILE__) + '/../../spec_helper'

describe "Standard Library" do
  describe "begin" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it "should execute each expression after the begin call and return final value" do
      result = @interpreter.run('
        (begin
          (define test 1)
          (set! test 2))
      ')
      expect(result).to be == 2
      expect(@interpreter.base_environment.find(:test)).to be == 2
    end

  end
end
