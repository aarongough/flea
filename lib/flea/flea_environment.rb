class FleaEnvironment < Hash
  def initialize( outer = nil )
    @outer = outer
    add_globals if(outer.nil?)
  end

  def find(key)
    return self if(self.has_key?(key) || @outer.nil?)
    return @outer.find(key)
  end
  
  def add_globals
    self.merge!({
      :"#t" => true,
      :"#f" => false
    })
  end
end