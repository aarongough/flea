# This class contains our logic for parsing
# S-Expressions. They are turned into a 
# native Ruby representation like:
#   [:def, :something [:lambda, [:a], [:do_something]]]
class SexpParser
  # Parse a string containing an S-Expression into a
  # nested set of Ruby arrays
  def parse( string )
    string.gsub!("(", " ( ")
    string.gsub!(")", " ) ")
    string_array = string.split
    tokens = process_tokens( string_array )
    structure( tokens )[1]
  end

  # Iterate over an array of strings and turn each
  # item into it's relevant token. ie: "string" -> :string, "1" -> 1
  def process_tokens( token_array )
    tokens = []
    token_array.each do |t|
      tokens << t and next if(is_paren?(t))
      tokens << t.to_i and next if( is_integer?(t))
      tokens << t.to_sym and next if( is_identifier?(t) || is_symbol?(t))
      raise "\nUnrecognized token: #{t}\n"
    end
    return tokens
  end

  # Iterate over a flat array of tokens and turn it
  # a nested set of arrays by detecting '(' and ')'
  def structure( token_array, offset = 0, internal = false )
    program = []
    while(offset < token_array.length)
      if( token_array[offset] == "(" )
        offset, array = structure( token_array, offset + 1, true )
        program << array
      elsif( token_array[offset] == ")" )
        break  
      else
        program << token_array[offset]
      end
      offset += 1
    end
    return [offset, program]
  end

  # Test to see whether a string represents a parentheses
  def is_paren?( string )
    is_match?( string, /[\(\)]+/ )
  end

  # Test to see whether or not a string represents an integer
  def is_integer?( string )
    is_match?( string, /[0-9]+/ )
  end

  # Test to see whether or not a string represents an identifier
  def is_identifier?( string )
    is_match?( string, /_*[a-zA-Z]+[a-zA-Z0-9_]*\??\!?/ )
  end

  # Test to see whether or not a string represents a symbol
  def is_symbol?( string )
    is_match?( string, /[\!\*\^=\/\+\-]+/ )
  end

  private

    def is_match?( string, pattern )
      match = string.match(pattern)
      return false unless match
      match[0].length == string.length
    end
end
