require "spec_helper"

describe "Standard Library" do
  describe "if" do
    before :each do
      @interpreter = Flea::Interpreter.new
    end
    
    context "only with consequent" do
      it "should execute consequent" do
        @interpreter.run('
          (if #t
            (define consequent 1))
        ')
        @interpreter.base_environment.should have_variable :consequent
      end
      
      it "should not execute consequent" do
        @interpreter.run('
          (if #f
            (define consequent 1))
        ')
        @interpreter.base_environment.should_not have_variable :consequent
      end
      
      it "should evaluate arguments before deciding on execution" do
        @interpreter.run('
          (define test #t)
          (if test
            (define consequent 1))
        ')
        @interpreter.base_environment.should have_variable :consequent
      end
    end
    
    context "with consequent and alternative" do
      it "should execute alternative" do
        @interpreter.run('
          (if #f
            (define consequent 1)
            (define alternative 1))
        ')
        @interpreter.base_environment.should_not have_variable :consequent
        @interpreter.base_environment.should have_variable :alternative
      end
      
      it "should execute consequent" do
        @interpreter.run('
          (if #t
            (define consequent 1)
            (define alternative 1))
        ')
        @interpreter.base_environment.should have_variable :consequent
        @interpreter.base_environment.should_not have_variable :alternative
      end
    end
    
  end
end