# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'addition operator' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should add several numbers' do
      result = interpreter.run('(+ 1 2 3)')
      expect(result).to eq(6)
    end

    it 'should evaluate its arguments before adding them' do
      result = interpreter.run('
        (define a 2)
        (+ a a a)
      ')

      expect(result).to eq(6)
    end
  end
end
