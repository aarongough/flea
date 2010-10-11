$standard_library.concat([
  [:define, :"+", [:__native_function, "list.inject {|sum, n| sum + n}"]],
  [:define, :"-", [:__native_function, "list.inject {|sum, n| sum - n}"]],
  [:define, :"*", [:__native_function, "list.inject {|sum, n| sum * n}"]],
  [:define, :"/", [:__native_function, "list.inject {|sum, n| sum / n}"]],
  [:define, :"=", [:__native_function, "!(list.map{|x| x == list[0]}).include?( false )"]],
  [:define, :"equal?", [:__native_function, "!(list.map{|x| x == list[0]}).include?( false )"]],
])