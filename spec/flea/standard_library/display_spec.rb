# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'display' do
    before :each do
      @interpreter = Flea::Interpreter.new
      @old_stdout = $stdout
      @buffer = StringIO.new
      $stdout = @buffer
    end

    it 'should output simple literal' do
      @interpreter.run('(display 1)')
      expect(@buffer.string).to eq('1')
    end

    it 'should output strings without quotes' do
      @interpreter.run('(display "foo")')
      expect(@buffer.string).to eq('foo')
    end

    it 'should output a list' do
      @interpreter.run('(display (quote (1 2 3)))')
      expect(@buffer.string).to eq('(1 2 3)')
    end

    it 'should output true and false using Scheme external representation' do
      @interpreter.run('(display #t)(display #f)')
      expect(@buffer.string).to eq('#t#f')
    end

    it 'should return the same value that it displayed' do
      result = @interpreter.run('(display "abc")')
      expect(result).to eq('abc')
    end

    after :each do
      $stdout = @old_stdout
    end
  end
end
