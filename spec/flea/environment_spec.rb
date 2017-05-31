require "spec_helper"

include Flea

describe Flea::Environment do
    
  describe ".new" do
    let(:environment) { Environment.new }

    it "returns an environment object" do
      expect(environment).to be_an Environment
    end
    
    it "returns an environment object with no parent" do
      expect(environment.parent).to be nil
    end

    it "adds base variables for #t and #f" do
      expect(environment).to have_variable :"#t"
      expect(environment).to have_variable :"#f"
      expect(environment.find(:"#t")).to be true
      expect(environment.find(:"#f")).to be false
    end
    
    it "returns an environment object with the specified parent" do
      parent_environment = double("Environment")
      environment = Environment.new(parent_environment)
      expect(environment.parent).to eq(parent_environment)
    end
  end
  
  describe "#has_variable?" do
    context "without a parent" do
      let(:environment) { Environment.new }
      
      it "returns false if the variable is not set in the current environment" do
        expect(environment).not_to have_variable :test
      end
      
      it "returns true if the variable is set in the current environment" do
        environment.define(:test, 1)
        expect(environment).to have_variable :test
      end
    end
    
    context "with a parent" do
      let(:parent_environment) { Environment.new }
      let(:environment) { Environment.new(parent_environment) }
      
      it "returns false if the variable is not set in the parent environment" do
        expect(environment).not_to have_variable :test
      end
      
      it "returns true if the variable is set in the parent environment" do
        parent_environment.define(:test, 1)
        expect(environment).to have_variable :test
      end
    end
  end
  
  describe "#define" do
    let(:environment) { Environment.new }

    it "sets a variable to the supplied value" do
      environment.define(:test, 1)
      expect(environment.find(:test)).to eq(1)
    end

    it "returns the value that it sets" do
      result = environment.define(:test, 1)
      expect(result).to eq(1)
    end
  end
  
  describe "#find" do
    context "without a parent" do
      let(:environment) { Environment.new }
      
      it "finds a variable in the current environment" do
        environment.define(:test, 1)
        expect(environment.find(:test)).to eq(1)
      end
      
      it "returns nil when variable is not set" do
        expect(environment.find(:test)).to be nil
      end
    end
    
    context "with a parent" do
      let(:parent_environment) { Environment.new }
      let(:environment) { Environment.new(parent_environment) }
      
      it "finds a variable in the parent environment" do
        environment.define(:test, 1)
        expect(environment.find(:test)).to eq(1)
      end
      
      it "returns a variable from the current environment if it is set in both current and parent" do
        environment.define(:test, 1)
        environment.define(:test, 5)

        expect(environment.find(:test)).to eq(5)
      end
      
      it "returns nil when variable is not set in the current or parent environment" do
        expect(environment.find(:test)).to be nil
      end
    end
  end
end
