require File.expand_path("../test_helper", File.dirname(__FILE__))

class ArrayTest < MiniTest::Unit::TestCase
  # Empty array
  test "empty array should return array" do
    assert { statement("[]").kind_of? SyntaxTree::Ruby::Array }
  end

  test "empty array should return array with no elements" do
    assert { statement("[]").elements == [] }
  end

  # Array
  test "array should return array" do
    assert { statement("[1, 2, 3]").kind_of? SyntaxTree::Ruby::Array }
  end

  test "array should return array with left delimiter" do
    assert { statement("[1, 2, 3]").left_delim.token == "[" }
  end

  test "array should return array with right delimiter" do
    assert { statement("[1, 2, 3]").right_delim.token == "]" }
  end

  test "array should return array with elements" do
    assert { statement("[1, 2, 3]").elements.kind_of? Array }
  end

  test "array should return array of integers" do
    assert { statement("[1, 2, 3]").first.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "array should return array of integers with prologue" do
    assert { statement("[1, 2, 3]").last.prologue.to_s == ", " }
  end

  test "array should return array of integers without prologue for first element" do
    assert { statement("[1, 2, 3]").first.prologue.to_s == "" }
  end

  test "array should return array of method calls with prologue" do
    assert { statement("[foo(), bar()]").last.identifier.prologue.to_s == ", " }
  end

  test "array should be enumerable" do
    assert { statement("[1, 2, 3]").collect.to_a.length == 3 }
  end
end
