module Flea
  class Core
    
    def self.native_function(content)
      eval "Proc.new do |environment, arguments|
        #{content}
      end"
    end
    
  end
end