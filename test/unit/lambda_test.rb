require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class LambdaTest < Test::Unit::TestCase
  
  test "should create new lambda that does not take arguments" do
    env = Interpreter.new.run([
      [:set!, :test, [:lambda, [],[
        :begin, [:print, 1]
      ]]]
    ])
    assert_kind_of Proc, env[:test]
  end
  
  test "should create and call new lambda without arguments" do
    old_stdout = $stdout
    buffer = StringIO.new
    $stdout = buffer
    env = Interpreter.new.run([
      [:set!, :test, [:lambda, [],[
        :begin, [:print, 1]
      ]]],
      [:test]      
    ])
    $stdout = old_stdout
    assert_equal "1", buffer.string
  end
  
  test "should create new lambda that does take arguments" do
    env = Interpreter.new.run([
      [:set!, :test, [:lambda, [:a],[
        :begin, [:print, :a]
      ]]]
    ])
    assert_kind_of Proc, env[:test]
  end
  
  test "should create and call new lambda with arguments" do
    old_stdout = $stdout
    buffer = StringIO.new
    $stdout = buffer
    env = Interpreter.new.run([
      [:set!, :test, [:lambda, [:a],[
        :begin, [:print, :a]
      ]]],
      [:test, 2]      
    ])
    $stdout = old_stdout
    assert_equal "2", buffer.string
  end
  
end