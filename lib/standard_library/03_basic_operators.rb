$standard_library.concat([
  [:set!, :"+", [:__native_function, "list.inject {|sum, n| sum + n}"]],
  [:set!, :"-", [:__native_function, "list.inject {|sum, n| sum - n}"]],
  [:set!, :"*", [:__native_function, "list.inject {|sum, n| sum * n}"]],
  [:set!, :"/", [:__native_function, "list.inject {|sum, n| sum / n}"]],
  [:set!, :"==", [:__native_function, "!(list.map{|x| x == list[0]}).include?( false )"]], 
])