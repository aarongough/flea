# frozen_string_literal: true

require 'spec_helper'

describe Flea::Interpreter do
  describe '.new' do
    it 'returns an Interpreter' do
      expect(Flea::Interpreter.new).to be_a Flea::Interpreter
    end

    it 'allows setting the base environment' do
      environment = double(:environment)
      interpreter = Flea::Interpreter.new(
        base_environment: environment,
        load_standard_library: false
      )
      expect(interpreter.base_environment).to eq(environment)
    end
  end

  describe '#run' do
    it 'runs a program and return the last output from the program' do
      interpreter = Flea::Interpreter.new
      result = interpreter.run('(define test 1)')

      expect(result).to eq(1)
      expect(interpreter.base_environment).to have_variable(:test)
    end
  end

  describe '#parse' do
    it 'returns an abstract syntax tree representing the supplied program' do
      ast = Flea::Interpreter.new.parse('(define test 1)')

      expect(ast).to eq([[:define, :test, 1]])
    end
  end

  describe '#evaluate' do
    let(:environment) { double(:environment) }
    let(:interpreter) { Flea::Interpreter.new(base_environment: environment, load_standard_library: false) }

    it 'returns the value of a variable' do
      allow(environment).to receive(:find).with(:test).and_return(1)
      expect(interpreter.evaluate(:test)).to eq(1)
    end

    it 'defines a variable in the current environment' do
      allow(environment).to receive(:define).with(:test, 1).and_return(1)
      expect(interpreter.evaluate([:define, :test, 1])).to eq(1)
    end

    it 'creates a native function' do
      result = interpreter.evaluate([:native_function, "
        Proc.new() do |arguments, interpreter|
          1
        end
      "])

      expect(result).to be_a Proc
      expect(result.call).to eq(1)
    end

    it 'calls a native function' do
      allow(environment).to receive(:find).with(:foo).and_return(proc { |_a, _b| 'bar' })
      result = interpreter.evaluate([:foo, 1, 2, 3])

      expect(result).to eq('bar')
    end

    [1, 1.0, 'string'].each do |literal|
      it "returns literal '#{literal}'" do
        result = interpreter.evaluate(literal)
        expect(result).to be literal
      end
    end
  end
end
