require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class NativeFunctionTest < Test::Unit::TestCase
  
  test "define native function" do
    env = Flea.run([
      [:set!, :test, [:__native_function, "puts list.inspect"]]
    ])
    assert_kind_of(Proc, env[:test])
  end
  
  test "define and call native function" do
    env = Flea.run([
      [:set!, :test, [:__native_function, "list"]],
      [:set!, :foo, [:test, 1, 2, 3]]
    ])
    assert_equal [1,2,3], env[:foo]
  end
  
end