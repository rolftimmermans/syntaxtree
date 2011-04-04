require File.expand_path("../test_helper", File.dirname(__FILE__))

class LiteralsTest < MiniTest::Unit::TestCase
  # Nil
  test "nil should return literal" do
    assert { statement("nil").kind_of? SyntaxTree::Ruby::Literal }
  end

  test "nil should return nil literal" do
    assert { statement("nil").kind_of? SyntaxTree::Ruby::Nil }
  end

  test "nil should return nil literal with nil value" do
    assert { statement("nil").value == nil }
  end

  test "nil should return nil literal with position" do
    assert { statement("  nil").position == pos(1, 2) }
  end

  # True
  test "true should return literal" do
    assert { statement("true").kind_of? SyntaxTree::Ruby::Literal }
  end

  test "true should return true literal" do
    assert { statement("true").kind_of? SyntaxTree::Ruby::True }
  end

  test "true should return true literal with true value" do
    assert { statement("true").value == true }
  end

  test "true should return true literal with position" do
    assert { statement("  true").position == pos(1, 2) }
  end

  test "true should return true literal with prologue" do
    assert { statement("  true").prologue.first.token == "  " }
  end

  # False
  test "false should return literal" do
    assert { statement("false").kind_of? SyntaxTree::Ruby::Literal }
  end

  test "false should return false literal" do
    assert { statement("false").kind_of? SyntaxTree::Ruby::False }
  end

  test "false should return false literal with false value" do
    assert { statement("false").value == false }
  end

  test "false should return false literal with position" do
    assert { statement("   false").position == pos(1, 3) }
  end

  test "false should return false literal with prologue" do
    assert { statement("   false").prologue.first.token == "   " }
  end

  # Integer
  test "integer should return integer literal" do
    assert { statement("1").kind_of? SyntaxTree::Ruby::Integer }
  end

  test "integer should return integer literal with integer value" do
    assert { statement("123").value == 123 }
  end

  test "integer should return integer literal with position" do
    assert { statement("123").position == pos(1, 0) }
  end

  test "integer should return integer literal with prologue" do
    assert { statement("   123").prologue.first.token == "   " }
  end

  # Float
  test "float should return float literal" do
    assert { statement("1.23").kind_of? SyntaxTree::Ruby::Float }
  end

  test "float should return float literal with float value" do
    assert { statement("1.23").value == 1.23 }
  end

  test "float should return float literal with position" do
    assert { statement(" 1.23").position == pos(1, 1) }
  end

  test "float should return float literal with prologue" do
    assert { statement(" 1.23").prologue.first.token == " " }
  end
end
