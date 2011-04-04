require File.expand_path("../test_helper", File.dirname(__FILE__))

class ArrayTest < MiniTest::Unit::TestCase
  # Array
  test "empty array should return array literal" do
    assert { statement("[]").kind_of? SyntaxTree::Ruby::Array }
  end

  test "array should return array literal" do
    assert { statement("[1, 2, 3]").kind_of? SyntaxTree::Ruby::Array }
  end

  test "array should return array literal with left delimiter" do
    assert { statement("[1, 2, 3]").left_delim.token == "[" }
  end

  test "array should return array literal with right delimiter" do
    assert { statement("[1, 2, 3]").right_delim.token == "]" }
  end

  test "array should return array literal with argument list" do
    assert { statement("[1, 2, 3]").elements.kind_of? SyntaxTree::Ruby::ArgumentList }
  end

  test "array should return array literal with argument list of integers" do
    assert { statement("[1, 2, 3]").elements.first.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "array should return array literal with argument list of integers with epilogue" do
    assert { statement("[1, 2, 3]").elements.first.epilogue.to_s == "," }
  end
end
