# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'append' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'union of two lists' do
      result = interpreter.run('
        (append (quote (1 2 3)) (quote (1 2 3)))
      ')

      expect(result).to eq([1, 2, 3, 1, 2, 3])
    end
  end
end
