# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'if' do
    let(:interpreter) { Flea::Interpreter.new }

    context 'only with consequent' do
      it 'should execute consequent' do
        interpreter.run('
          (if #t
            (define consequent 1))
        ')
        expect(interpreter.base_environment).to have_variable(:consequent)
      end

      it 'should not execute consequent' do
        interpreter.run('
          (if #f
            (define consequent 1))
        ')
        expect(interpreter.base_environment).not_to have_variable(:consequent)
      end

      it 'should evaluate arguments before deciding on execution' do
        interpreter.run('
          (define test #t)
          (if test
            (define consequent 1))
        ')
        expect(interpreter.base_environment).to have_variable(:consequent)
      end
    end

    context 'with consequent and alternative' do
      it 'should execute alternative' do
        interpreter.run('
          (if #f
            (define consequent 1)
            (define alternative 1))
        ')
        expect(interpreter.base_environment).not_to have_variable(:consequent)
        expect(interpreter.base_environment).to have_variable(:alternative)
      end

      it 'should execute consequent' do
        interpreter.run('
          (if #t
            (define consequent 1)
            (define alternative 1))
        ')
        expect(interpreter.base_environment).to have_variable(:consequent)
        expect(interpreter.base_environment).not_to have_variable(:alternative)
      end
    end
  end
end
