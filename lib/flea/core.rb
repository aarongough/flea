module Flea
  class Core
    
    def self.create_native_function(content)
      eval "Proc.new do |environment, arguments|
        #{content}
      end"
    end
    
  end
end