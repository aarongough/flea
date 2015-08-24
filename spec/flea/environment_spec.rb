require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Environment" do

    describe ".new" do
      it "should return an environment object" do
        expect(Flea::Environment.new).to be_a Flea::Environment
      end

      it "should return an environment object with no parent" do
        environment = Flea::Environment.new
        expect(environment.parent).to be_nil
      end

      it "should return an environment object with the specified parent" do
        parent_environment = double("Flea::Environment")
        environment = Flea::Environment.new(parent_environment)
        expect(environment.parent).to be parent_environment
      end

      it "should add base variables for #t and #f" do
        environment = Flea::Environment.new
        expect(environment).to have_variable :"#t"
        expect(environment).to have_variable :"#f"
        expect(environment.find(:"#t")).to be true
        expect(environment.find(:"#f")).to be false
      end
    end

    describe "#has_variable?" do
      context "without a parent" do
        before :each do
          @environment = Flea::Environment.new
        end

        it "should return false if the variable is not set in the current environment" do
          expect(@environment).not_to have_variable :test
        end

        it "should return true if the variable is set in the current environment" do
          @environment.define(:test, 1)
          expect(@environment).to have_variable :test
        end
      end

      context "with a parent" do
        before :each do
          @parent_environment = Flea::Environment.new
          @environment = Flea::Environment.new(@parent_environment)
        end

        it "should return false if the variable is not set in the parent environment" do
          expect(@environment).to_not have_variable :test
        end

        it "should return true if the variable is set in the parent environment" do
          @parent_environment.define(:test, 1)
          expect(@environment).to have_variable :test
        end
      end
    end

    describe "#define" do
      it "should set a variable to the supplied value" do
        env = Flea::Environment.new
        result = env.define(:test, 1)
        expect(env).to have_variable :test
        expect(env.find(:test)).to be == 1
        expect(result).to be == 1
      end
    end

    describe "#find" do
      context "without a parent" do
        before :each do
          @environment = Flea::Environment.new
          @environment.define(:test, 1)
        end

        it "should find a variable in the current environment" do
          expect(@environment.find(:test)).to be == 1
        end

        it "should return nil when variable is not set" do
          expect(@environment.find(:fake)).to be_nil
        end
      end

      context "with a parent" do
        before :each do
          @parent_environment = Flea::Environment.new
          @environment = Flea::Environment.new(@parent_environment)
          @parent_environment.define(:test, 1)
        end

        it "should find a variable in the parent environment" do
          expect(@environment.find(:test)).to be == 1
        end

        it "should return a variable from the current environment if it is set in both current and parent" do
          @environment.define(:test, 5)
          expect(@environment.find(:test)).to be == 5
        end

        it "should return nil when variable is not set in the current or parent environment" do
          expect(@environment.find(:fake)).to be_nil
        end
      end
    end
  end
end
