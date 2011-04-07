require File.expand_path("../test_helper", File.dirname(__FILE__))

class LiteralValuesTest < Test::Unit::TestCase
  # Nil
  test "nil should return keyword" do
    assert { statement("nil").kind_of? Ruby::Keyword }
  end

  test "nil should return nil" do
    assert { statement("nil").kind_of? Ruby::Nil }
  end

  test "nil should return nil with nil value" do
    assert { statement("nil").value == nil }
  end

  test "nil should return nil with position" do
    assert { statement("  nil").position == pos(0, 2) }
  end

  # True
  test "true should return keyword" do
    assert { statement("true").kind_of? Ruby::Keyword }
  end

  test "true should return true" do
    assert { statement("true").kind_of? Ruby::True }
  end

  test "true should return true with true value" do
    assert { statement("true").value == true }
  end

  test "true should return true with position" do
    assert { statement("  true").position == pos(0, 2) }
  end

  test "true should return true with prologue" do
    assert { statement("  true").prologue.first.token == "  " }
  end

  # False
  test "false should return keyword" do
    assert { statement("false").kind_of? Ruby::Keyword }
  end

  test "false should return false" do
    assert { statement("false").kind_of? Ruby::False }
  end

  test "false should return false with false value" do
    assert { statement("false").value == false }
  end

  test "false should return false with position" do
    assert { statement("   false").position == pos(0, 3) }
  end

  test "false should return false with prologue" do
    assert { statement("   false").prologue.first.token == "   " }
  end

  # Integer
  test "integer should return literal" do
    assert { statement("1").kind_of? Ruby::Literal }
  end

  test "integer should return integer literal" do
    assert { statement("1").kind_of? Ruby::Integer }
  end

  test "integer should return integer literal with integer value" do
    assert { statement("123").value == 123 }
  end

  test "integer should return integer literal with position" do
    assert { statement("123").position == pos(0, 0) }
  end

  test "integer should return integer literal with prologue" do
    assert { statement("   123").prologue.first.token == "   " }
  end

  # Float
  test "float should return literal" do
    assert { statement("1.23").kind_of? Ruby::Literal }
  end

  test "float should return float literal" do
    assert { statement("1.23").kind_of? Ruby::Float }
  end

  test "float should return float literal with float value" do
    assert { statement("1.23").value == 1.23 }
  end

  test "float should return float literal with position" do
    assert { statement(" 1.23").position == pos(0, 1) }
  end

  test "float should return float literal with prologue" do
    assert { statement(" 1.23").prologue.first.token == " " }
  end

  # Character
  test "character should return literal" do
    assert { statement("?x").kind_of? Ruby::Literal }
  end

  test "character should return character literal" do
    assert { statement("?x").kind_of? Ruby::Character }
  end

  test "character should return character literal with character value" do
    assert { statement("?x").value == ?x }
  end

  test "character should return character literal with position" do
    assert { statement(" ?x").position == pos(0, 1) }
  end

  test "character should return character literal with prologue" do
    assert { statement(" ?x").prologue.first.token == " " }
  end

  # Label
  test "label should return label literal" do
    assert { statement("{label: bar}").first.key.kind_of? Ruby::Label }
  end

  test "label should return label literal with token" do
    assert { statement("{label: bar}").first.key.token == "label:" }
  end

  test "label should return label literal with symbol value" do
    assert { statement("{label: bar}").first.key.value == :label }
  end

  test "label should return label literal with position" do
    assert { statement(" {label: bar}").first.key.position == pos(0, 2) }
  end

  test "label should return label literal with prologue" do
    assert { statement("{  label: bar}").first.key.prologue.first.token == "  " }
  end
end
