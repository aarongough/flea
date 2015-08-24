require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "Flea::Interpreter" do

    describe "#new" do
      it "should return an Interpreter" do
        expect(Flea::Interpreter.new).to be_a Flea::Interpreter
      end

      it "should allow setting the base environment to use" do
        environment = double("Flea::Environment")
        interpreter = Flea::Interpreter.new(
          :base_environment => environment,
          :load_standard_library => false
        )
        expect(interpreter.base_environment).to be environment
      end
    end

    describe ".run" do
      it "should run a program and return the last output from the program" do
        interpreter = Flea::Interpreter.new
        result = interpreter.run("(define test 1)")
        expect(result).to be == 1
        expect(interpreter.base_environment).to have_variable :test
      end
    end

    describe ".parse" do
      it "should return an abstract syntax tree representing the supplied program" do
        ast = Flea::Interpreter.new.parse("(define test 1)")
        expect(ast).to be == [[:define, :test, 1]]
      end
    end

    describe ".evaluate" do
      before :each do
        @environment = double("Environment")
        @interpreter = Flea::Interpreter.new(
          :base_environment => @environment,
          :load_standard_library => false
        )
      end

      it "should return the value of a variable" do
        expect(@environment).to receive(:find).with(:test).and_return(1)
        result = @interpreter.evaluate(:test)
        expect(result).to be == 1
      end

      it "should define a variable in the current environment" do
        expect(@environment).to receive(:define).with(:test, 1).and_return(1)
        result = @interpreter.evaluate([:define, :test, 1])
        expect(result).to be == 1
      end

      it "should create a native function" do
        result = @interpreter.evaluate([:native_function, "
          Proc.new() do |arguments, interpreter|
            1
          end
        "])
        expect(result).to be_a Proc
        expect(result.call).to be == 1
      end

      it "should call a native function" do
        expect(@environment).to receive(:find).with(:foo).and_return(Proc.new {|a,b| "bar"})
        result = @interpreter.evaluate([:foo, 1, 2, 3])
        expect(result).to be == "bar"
      end

      [1, 1.0, "string"].each do |literal|
        it "should return literal '#{literal}' as is" do
          result = @interpreter.evaluate(literal)
          expect(result).to be literal
        end
      end
    end

  end
end
