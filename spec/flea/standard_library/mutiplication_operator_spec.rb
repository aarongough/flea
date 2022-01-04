# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'multiplication operator' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should multiply several numbers' do
      result = interpreter.run('(* 2 2 2)')
      expect(result).to eq(8)
    end

    it 'should evaluate its arguments before multiplying them' do
      result = interpreter.run('
        (define a 2)
        (* a a a)
      ')
      expect(result).to eq(8)
    end
  end
end
