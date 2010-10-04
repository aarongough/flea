$standard_library.concat([
  [:set!, :begin, [:__native_function, "
    val = 0
    list.each do |i|
      val = evaluate(i, env)
    end
    val
  "]]
])