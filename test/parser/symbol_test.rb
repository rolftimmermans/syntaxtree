require File.expand_path("../test_helper", File.dirname(__FILE__))

class SymbolTest < Test::Unit::TestCase
  # Symbol
  test "symbol should return symbol literal" do
    assert { statement(":abc").kind_of? Ruby::Symbol }
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
    assert { statement(':"#{foo}"').kind_of? Ruby::DynamicSymbol }
  end

  test "dynamic symbol should return dynamic symbol literal with string contents" do
    assert { statement(':"my #{foo}"').contents.kind_of? Ruby::StringContents }
  end

  test "dynamic symbol should return dynamic symbol literal with string literal for interpolated string" do
    assert { statement(':"my #{foo}"').contents.first.kind_of? Ruby::StringPart }
  end

  test "dynamic symbol should return dynamic symbol literal with string value for literal in interpolated string" do
    assert { statement(':"my #{foo}"').contents.first.token == "my " }
  end

  test "dynamic symbol should return dynamic symbol literal with embedded expression for interpolated string" do
    assert { statement(':"my #{foo}"').contents.elements[1].kind_of? Ruby::EmbeddedExpression }
  end

  test "dynamic symbol should return dynamic symbol literal with statement in expression for interpolated string" do
    assert { statement(':"my #{foo}"').contents.elements[1].statements.first.token == "foo" }
  end
end
