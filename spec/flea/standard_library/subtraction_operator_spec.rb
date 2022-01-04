# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'subtraction operator' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should subtract several numbers' do
      result = interpreter.run('(- 9 2 2)')
      expect(result).to eq(5)
    end

    it 'should evaluate its arguments before subtracting them' do
      result = interpreter.run('
        (define a 2)
        (define b 9)
        (- b a a)
      ')

      expect(result).to eq(5)
    end
  end
end
