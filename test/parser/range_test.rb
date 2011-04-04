require File.expand_path("../test_helper", File.dirname(__FILE__))

class RangeTest < MiniTest::Unit::TestCase
  # Inclusive range
  test "range should return range literal" do
    assert { statement("1..10").kind_of? SyntaxTree::Ruby::Range }
  end

  test "range should return range literal with begin expression" do
    assert { statement("1..10").begin.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "range should return range literal with correct value for begin expression" do
    assert { statement("1..10").begin.value == 1 }
  end

  test "range should return range literal with end expression" do
    assert { statement("1..10").end.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "range should return range literal with correct value for end expression" do
    assert { statement("1..10").end.value == 10 }
  end

  test "range should return range literal with correct operator" do
    assert { statement("1..10").operator.token == ".." }
  end

  test "range should return range literal with correct operator position" do
    assert { statement(" 1..10").operator.position == pos(1, 2) }
  end

  # Exclusive range
  test "range should return range literal for exclusive range" do
    assert { statement("1...10").kind_of? SyntaxTree::Ruby::Range }
  end

  test "range should return range literal with begin expression for exclusive range" do
    assert { statement("1...10").begin.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "range should return range literal with correct value for begin expression for exclusive range" do
    assert { statement("1...10").begin.value == 1 }
  end

  test "range should return range literal with end expression for exclusive range" do
    assert { statement("1...10").end.kind_of? SyntaxTree::Ruby::Integer }
  end

  test "range should return range literal with correct value for end expression for exclusive range" do
    assert { statement("1...10").end.value == 10 }
  end

  test "range should return range literal with correct operator for exclusive range" do
    assert { statement("1...10").operator.token == "..." }
  end

  test "range should return range literal with correct operator position for exclusive range" do
    assert { statement("  1...10").operator.position == pos(1, 3) }
  end
end
