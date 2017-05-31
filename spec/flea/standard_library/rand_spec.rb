require "spec_helper"

describe "Standard Library" do
  describe "rand" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    10.times do
      it "should return a random number lower than or equal to 10" do
        result = @interpreter.run('(rand 10)')
        result.should < 11
      end
      
      it "should evaluate its arguments" do
        result = @interpreter.run('
          (define a 10)
          (rand a)
        ')
        result.should < 11
      end
    end
  
  end
end