$standard_library.concat([
  [:define, :begin, [:__native_function, "
    val = 0
    list.each do |i|
      val = evaluate(i, env)
    end
    val
  "]]
])