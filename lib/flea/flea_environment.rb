class FleaEnvironment < Hash
  def initialize( outer = nil )
    @outer = outer
  end

  def find(key)
    return self if(self.has_key?(key) || @outer.nil?)
    return @outer.find(key)
  end
end