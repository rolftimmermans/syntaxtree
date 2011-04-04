require File.expand_path("../test_helper", File.dirname(__FILE__))

class SymbolTest < MiniTest::Unit::TestCase
  # Symbol
  test "symbol should return symbol literal" do
    assert { statement(":abc").kind_of? SyntaxTree::Ruby::Symbol }
  end

  test "symbol should return symbol literal with symbol value" do
    assert { statement(":abc").value == :abc }
  end

  test "symbol should return symbol literal with left delimiter" do
    assert { statement(":abc").left_delim.token == ":" }
  end

  test "symbol should return symbol literal with prologue" do
    assert { statement("  :abc").left_delim.prologue.first.token == "  " }
  end

  # Dynamic symbol
  test "dynamic symbol should return dynamic symbol literal" do
    assert { statement(':"#{foo}"').kind_of? SyntaxTree::Ruby::DynamicSymbol }
  end

  test "dynamic symbol should return dynamic symbol literal with literl for interpolated string" do
    assert { statement(':"my #{foo}"').elements.first.kind_of? SyntaxTree::Ruby::Literal }
  end

  test "dynamic symbol should return dynamic symbol literal with string value for literal in interpolated string" do
    assert { statement(':"my #{foo}"').elements.first.token == "my " }
  end

  test "dynamic symbol should return dynamic symbol literal with embedded expression for interpolated string" do
    assert { statement(':"my #{foo}"').elements[1].kind_of? SyntaxTree::Ruby::EmbeddedExpression }
  end

  test "dynamic symbol should return dynamic symbol literal with statement in expression for interpolated string" do
    assert { statement(':"my #{foo}"').elements[1].statements.first.token == "foo" }
  end
end
