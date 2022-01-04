# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'cons' do
    before :each do
      @interpreter = Flea::Interpreter.new
    end

    it 'should create a list from an atom and an empty list' do
      result = @interpreter.run("(cons 'a '())")
      expect(result).to eq([:a])
    end

    it 'should create a list from a pair of lists' do
      result = @interpreter.run("(cons '(a) '(b c d))")
      expect(result).to eq([[:a], :b, :c, :d])
    end

    it 'should push an atom on an existing list' do
      result = @interpreter.run('(cons "a" \'(b c ))')
      expect(result).to eq(['a', :b, :c])
    end
  end
end
