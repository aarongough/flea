$standard_library.concat([
  [:define, :if, [:__native_function, "
    evaluate(list[1], env) if(evaluate(list[0], env))
  "]]
])