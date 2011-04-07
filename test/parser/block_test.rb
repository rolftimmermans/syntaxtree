require File.expand_path("../test_helper", File.dirname(__FILE__))

class BlockTest < Test::Unit::TestCase
  # Block without parameters
  test "call with block without parameters should return block" do
    assert { statement("foo(a, b) { puts x }").block.kind_of? Ruby::Block }
  end

  test "call with block without parameters should return block with param list" do
    assert { statement("foo(a, b) { puts x }").block.parameters.kind_of? Ruby::ParameterList }
  end

  test "call with block with empty parameters should return block with param list" do
    assert { statement("foo(a, b) { || puts x }").block.parameters.kind_of? Ruby::ParameterList }
  end

  test "call with block with empty parameters should return block with param list with left delim" do
    assert { statement("foo(a, b) { || puts x }").block.parameters.left_delim.token == "|" }
  end

  test "call with block with empty parameters should return block with param list with right delim" do
    assert { statement("foo(a, b) { || puts x }").block.parameters.right_delim.token == "|" }
  end

  test "call with block with empty parameters should return block with param list with left delim position" do
    assert { statement("foo(a, b) { || puts x }").block.parameters.left_delim.position == pos(0, 12) }
  end

  test "call with block with empty parameters should return block with param list with right delim position" do
    assert { statement("foo(a, b) { || puts x }").block.parameters.right_delim.position == pos(0, 13) }
  end

  test "call with block with empty parameters with space should return block with param list" do
    assert { statement("foo(a, b) { |  | puts x }").block.parameters.kind_of? Ruby::ParameterList }
  end

  test "call with block with empty parameters with space should return block with param list with left delim" do
    assert { statement("foo(a, b) { |  | puts x }").block.parameters.left_delim.token == "|" }
  end

  test "call with block with empty parameters with space should return block with param list with right delim" do
    assert { statement("foo(a, b) { |  | puts x }").block.parameters.right_delim.token == "|" }
  end

  test "call with block with empty parameters with space sshould return block with param list with left delim position" do
    assert { statement("foo(a, b) { |  | puts x }").block.parameters.left_delim.position == pos(0, 12) }
  end

  test "call with block with empty parameters with space sshould return block with param list with right delim position" do
    assert { statement("foo(a, b) { |  | puts x }").block.parameters.right_delim.position == pos(0, 15) }
  end

  # Block with parameter
  test "call with block should return block" do
    assert { statement("foo(a, b) { |x| puts x }").block.kind_of? Ruby::Block }
  end

  test "call with block should return block with param list" do
    assert { statement("foo(a, b) { |x| puts x }").block.parameters.kind_of? Ruby::ParameterList }
  end

  test "call with block should return block with param list with param" do
    assert { statement("foo(a, b) { |x| puts x }").block.parameters.first.kind_of? Ruby::Identifier }
  end

  test "call with block should return block with param list with param with token" do
    assert { statement("foo(a, b) { |x| puts x }").block.parameters.first.token == "x" }
  end

  # Default parameters
  test "call with block with default param should return block with param list" do
    assert { statement("foo(a, b) { |x, y = 3| puts x }").block.parameters.kind_of? Ruby::ParameterList }
  end

  test "call with block with default param should return block with param list with param" do
    assert { statement("foo(a, b) { |x, y = 3| puts x }").block.parameters.last.kind_of? Ruby::DefaultParameter }
  end

  test "call with block with default param should return block with param list with param with identifier" do
    assert { statement("foo(a, b) { |x, y = 3| puts x }").block.parameters.last.identifier.kind_of? Ruby::Identifier }
  end

  test "call with block with default param should return block with param list with param with token" do
    assert { statement("foo(a, b) { |x, y = 3| puts x }").block.parameters.last.identifier.token == "y" }
  end

  test "call with block with regular param after default should return block with param list with param with token" do
    assert { statement("foo(a, b) { |x, y = 3, z| puts x }").block.parameters.last.token == "z" }
  end

  test "call with block with only a default param should return block with param list with param" do
    assert { statement("foo(a, b) { |x = 3| puts x }").block.parameters.first.kind_of? Ruby::DefaultParameter }
  end

  test "call with block with only a default param should return block with param list with param with identifier" do
    assert { statement("foo(a, b) { |x = 3| puts x }").block.parameters.first.identifier.kind_of? Ruby::Identifier }
  end

  # Splat parameters
  test "call with block with splat param block should return block with param list with splat param" do
    assert { statement("foo(a, b) { |x, *other| puts x }").block.parameters.last.kind_of? Ruby::SplatParameter }
  end

  test "call with block with splat param block should return block with param list with splat param with identifier" do
    assert { statement("foo(a, b) { |x, *other| puts x }").block.parameters.last.identifier.kind_of? Ruby::Identifier }
  end

  test "call with block with splat param block should return block with param list with splat param with identifier with token" do
    assert { statement("foo(a, b) { |x, *other| puts x }").block.parameters.last.identifier.token == "other" }
  end

  test "call with block with splat param block should return block with param list with splat param with left delim" do
    assert { statement("foo(a, b) { |x, *other| puts x }").block.parameters.last.left_delim.token == "*" }
  end

  # Block parameters
  test "call with block with block param block should return block with param list with block param" do
    assert { statement("foo(a, b) { |x, &block| puts x }").block.parameters.last.kind_of? Ruby::BlockParameter }
  end

  test "call with block with block param block should return block with param list with block param with identifier" do
    assert { statement("foo(a, b) { |x, &block| puts x }").block.parameters.last.identifier.kind_of? Ruby::Identifier }
  end

  test "call with block with block param block should return block with param list with block param with identifier with token" do
    assert { statement("foo(a, b) { |x, &block| puts x }").block.parameters.last.identifier.token == "block" }
  end

  test "call with block with block param block should return block with param list with block param with left delim" do
    assert { statement("foo(a, b) { |x, &block| puts x }").block.parameters.last.left_delim.token == "&" }
  end

  # Statements
  test "call with empty block should return block with statement list" do
    assert { statement("foo(a, b) { }").block.statements.kind_of? Ruby::Statements }
  end

  test "call with empty block should return block with empty statements" do
    assert { statement("foo(a, b) { }").block.statements.elements == [] }
  end

  test "call with block should return block with statement list" do
    assert { statement("foo(a, b) { foo\nbar; baz }").block.statements.kind_of? Ruby::Statements }
  end

  test "call with block should return block with statements" do
    assert { statement("foo(a, b) { foo\nbar; baz }").block.statements.first.kind_of? Ruby::Identifier }
  end

  test "call with block should return block with statement size" do
    assert { statement("foo(a, b) { foo\nbar; baz }").block.statements.size == 3 }
  end
end
