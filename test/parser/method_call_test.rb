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

  # Splat arguments
  test "method call with splat argument should return method call" do
    assert { statement("foo(1, *args)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with splat argument should return method call with argument list" do
    assert { statement("foo(1, *args)").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call with splat argument should return method call with argument list with splat argument" do
    assert { statement("foo(1, *args)").arguments.last.kind_of? SyntaxTree::Ruby::SplatArgument }
  end

  test "method call with splat argument should return method call with argument list with splat argument identifier" do
    assert { statement("foo(1, *args)").arguments.last.identifier.token == "args" }
  end

  test "method call with splat argument should return method call with argument list with splat argument with left delim" do
    assert { statement("foo(1, *args)").arguments.last.left_delim.token == "*" }
  end

  # Block arguments
  test "method call with block argument should return method call" do
    assert { statement("foo(1, &block)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with block argument should return method call with argument list" do
    assert { statement("foo(1, &block)").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call with block argument should return method call with argument list with block argument" do
    assert { statement("foo(1, &block)").arguments.last.kind_of? SyntaxTree::Ruby::BlockArgument }
  end

  test "method call with block argument should return method call with argument list with block argument with identifier" do
    assert { statement("foo(1, &block)").arguments.last.identifier.token == "block" }
  end

  test "method call with block argument should return method call with argument list with block argument with left delim" do
    assert { statement("foo(1, &block)").arguments.last.left_delim.token == "&" }
  end

  # Receivers
  test "method call with receiver should return method call" do
    assert { statement("foo.bar(1, 2)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with receiver should return method call with receiver" do
    assert { statement("foo.bar(1, 2)").receiver.kind_of? SyntaxTree::Ruby::Identifier }
  end

  test "method call with receiver should return method call with receiver with token" do
    assert { statement("foo.bar(1, 2)").receiver.token == "foo" }
  end

  test "method call with receiver should return method call with operator" do
    assert { statement("foo.bar(1, 2)").operator.kind_of? SyntaxTree::Ruby::Token }
  end

  test "method call with receiver should return method call with operator with token" do
    assert { statement("foo.bar(1, 2)").operator.token == "." }
  end

  # Const receivers
  test "method call with constant receiver should return method call" do
    assert { statement("Foo.bar(1, 2)").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call with constant receiver should return method call with constant receiver" do
    assert { statement("Foo.bar(1, 2)").receiver.kind_of? SyntaxTree::Ruby::Constant }
  end

  test "method call with constant receiver should return method call with constant receiver with token" do
    assert { statement("FooBar.bar(1, 2)").receiver.token == "FooBar" }
  end

  test "method call with constant receiver with double colon operator should return method call with operator" do
    assert { statement("FooBar::bar(1, 2)").operator.token == "::" }
  end

  # Without braces
  test "method call without braces should return method call" do
    assert { statement("foo 1, 2").kind_of? SyntaxTree::Ruby::MethodCall }
  end

  test "method call without braces should return method call without receiver" do
    assert { statement("foo 1, 2").receiver == nil }
  end

  test "method call without braces should return method call without operator" do
    assert { statement("foo 1, 2").operator == nil }
  end

  test "method call without braces should return method call with argument list" do
    assert { statement("foo 1, 2").arguments.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "method call without braces should return method call with argument list without left delimiter" do
    assert { statement("foo 1, 2").arguments.left_delim == nil }
  end

  test "method call without braces should return method call with argument list without right delimiter" do
    assert { statement("foo 1, 2").arguments.right_delim == nil }
  end
end
