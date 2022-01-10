# frozen_string_literal: true

module Flea
  class Environment
    attr_accessor :parent, :table

    def initialize(parent = nil)
      @parent = parent
      @table = {}
      add_globals if @parent.nil?
    end

    def has_variable?(name)
      return true if @table.key?(name)
      return false if @parent.nil?

      @parent.has_variable?(name)
    end

    def find(name)
      return @table[name] if @table.key?(name)
      return nil if @parent.nil?

      @parent.find(name)
    end

    def define(name, value)
      @table[name] = value
    end

    private

    def add_globals
      @table.merge!(
        '#t': true,
        '#f': false
      )
    end
  end
end
