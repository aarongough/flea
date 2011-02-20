module Flea
  class Environment
    
    attr_accessor :parent
    
    def initialize(parent = nil)
      @parent = parent
      @table = {}
      add_globals if @parent.nil?
    end
    
    def has_variable?(name)
      return true if @table.has_key?(name)
      return false if @parent.nil?
      return @parent.has_variable?(name)
    end
    
    def find(name)
      return @table[name] if @table.has_key?(name)
      return nil if @parent.nil?
      return @parent.find(name)
    end
    
    def define(name, value)
      @table[name] = value
    end
    
    private
    
    def add_globals
      @table.merge!({
        :"#t" => true,
        :"#f" => false
      })
    end
    
  end
end