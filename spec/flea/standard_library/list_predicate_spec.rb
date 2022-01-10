# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'list?' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should should return true for an empty list' do
      result = interpreter.run("(list? (quote ()))")
      expect(result).to be true
    end

    it 'return true for a populated list' do
      result = interpreter.run("(list? (quote (a b c)))")
      expect(result).to be true
    end

    it 'should return false for an atom' do
      result = interpreter.run("(list? (quote a))")
      expect(result).to be false
    end
  end
end
