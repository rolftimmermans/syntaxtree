require File.expand_path("../test_helper", File.dirname(__FILE__))

class MethodCallTest < MiniTest::Unit::TestCase
  # Empty argument list
  test "method call with empty arguments should return method call" do
    assert { statement("foo()").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with empty arguments should return method call without receiver" do
    assert { statement("foo()").receiver == nil }
  end

  test "method call with empty arguments should return method call without operator" do
    assert { statement("foo()").operator == nil }
  end

  test "method call with empty arguments should return method call with argument list" do
    assert { statement("foo()").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call with empty arguments should return method call with argument list with left delimiter" do
    assert { statement("foo()").arguments.left_delim.token == "(" }
  end

  test "method call with empty arguments should return method call with argument list with right delimiter" do
    assert { statement("foo()").arguments.right_delim.token == ")" }
  end

  test "method call with empty arguments should return delimiters in nodes" do
    assert { statement("foo()").arguments.nodes.first.kind_of? SyntaxTree::Ruby::Token }
  end

  # Simple arguments
  test "method call with primitve arguments should return method call" do
    assert { statement("foo(1, 2)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with primitve arguments should return method call with argument list" do
    assert { statement("foo(1, 2)").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call with primitve arguments should return method call with argument list with left delimiter" do
    assert { statement("foo(1, 2)").arguments.left_delim.token == "(" }
  end

  test "method call with primitve arguments should return method call with argument list with right delimiter" do
    assert { statement("foo(1, 2)").arguments.right_delim.token == ")" }
  end

  test "method call with primitve arguments should return method call with primitive argument" do
    assert { statement("foo(1, 2)").arguments.first.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "method call with primitve arguments should return method call with primitive argument with token" do
    assert { statement("foo(1, 2)").arguments.first.token == "1" }
  end

  test "method call with primitve arguments should return method call with primitive argument with prologue" do
    assert { statement("foo(1, 2)").arguments.last.prologue.to_s == ", " }
  end

  # Hash arguments
  test "method call with hash argument should return method call" do
    assert { statement("foo(1, :foo => :bar)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with hash argument should return method call with argument list" do
    assert { statement("foo(1, :foo => :bar)").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call with hash argument should return method call with argument list with hash" do
    assert { statement("foo(1, :foo => :bar)").arguments.last.kind_of? SyntaxTree::Ruby::Hash }
  end

  test "method call with hash argument should return method call with argument list with hash assoc" do
    assert { statement("foo(1, :foo => :bar)").arguments.last.first.kind_of? SyntaxTree::Ruby::Association }
  end

  test "method call with hash argument should return method call with argument list with hash with assoc key" do
    assert { statement("foo(1, :foo => :bar)").arguments.last.first.key.identifier.token == "foo" }
  end

  test "method call with hash argument should return method call with argument list with hash with assoc value" do
    assert { statement("foo(1, :foo => :bar)").arguments.last.first.value.identifier.token == "bar" }
  end

  test "method call with hash argument should return method call with argument list with hash with assoc operator" do
    assert { statement("foo(1, :foo => :bar)").arguments.last.first.operator.token == "=>" }
  end
end
