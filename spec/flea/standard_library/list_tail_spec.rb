# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'list-tail' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should return trailing subset of list' do
      result = interpreter.run('
        (list-tail (quote (1 2 3 4 5)) 2)
      ')

      expect(result).to eq([3, 4, 5])
    end
  end
end
