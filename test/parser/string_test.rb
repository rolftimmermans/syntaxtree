require File.expand_path("../test_helper", File.dirname(__FILE__))

class StringTest < MiniTest::Unit::TestCase
  # Single quotes
  test "string should return string literal" do
    assert { statement("'abc'").kind_of? SyntaxTree::Ruby::String }
  end

  test "string should return string with left delim" do
    assert { statement("'abc'").left_delim.token == "'" }
  end

  test "string should return string with left delim at correct position" do
    assert { statement("'abc'").left_delim.position == pos(1, 0) }
  end

  test "string should return string with right delim" do
    assert { statement("'abc'").right_delim.token == "'" }
  end

  test "string should return string with right delim at correct position" do
    assert { statement("'abc'").right_delim.position == pos(1, 4) }
  end

  test "string should return string with elements" do
    assert { statement("'abc'").elements.kind_of? Array }
  end

  test "string should return string with string value" do
    assert { statement("'abc'").first.token == "abc" }
  end

  test "string should return string with string value for string that spans lines" do
    assert { statement("'abc\ndef\nghi'").inject("") { |s, l| s << l.token } == "abc\ndef\nghi" }
  end

  # Quoted string
  test "string should return string with left delim for quoted string" do
    assert { statement("%Q{abc}").left_delim.token == "%Q{" }
  end

  test "string should return string with right delim for quoted string" do
    assert { statement("%Q{abc}").right_delim.token == "}" }
  end

  # Interpolated string
  test "string should return string with left delim for interpolated string" do
    assert { statement('"my #{foo}"').left_delim.token == '"' }
  end

  test "string should return string with right delim for interpolated string" do
    assert { statement('"my #{foo}"').right_delim.token == '"' }
  end

  test "string should return string with for interpolated string" do
    assert { statement('"my #{foo}"').first.kind_of? SyntaxTree::Ruby::Literal }
  end

  test "string should return string with string value for in interpolated string" do
    assert { statement('"my #{foo}"').first.token == "my " }
  end

  test "string should return string with embedded expression for interpolated string" do
    assert { statement('"my #{foo}"').elements[1].kind_of? SyntaxTree::Ruby::EmbeddedExpression }
  end

  test "string should return string with statement in expression for interpolated string" do
    assert { statement('"my #{foo}"').elements[1].statements.first.token == "foo" }
  end

  test "string should return string with embedded expression with left delimiter for interpolated string" do
    assert { statement('"my #{foo}"').elements[1].left_delim.token == '#{' }
  end

  test "string should return string with embedded expression with right delimiter for interpolated string" do
    assert { statement('"my #{foo}"').elements[1].right_delim.token == '}' }
  end
end
