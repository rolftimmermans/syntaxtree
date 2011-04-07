require File.expand_path("../test_helper", File.dirname(__FILE__))

class StringTest < Test::Unit::TestCase
  # Single quotes
  test "string should return string" do
    assert { statement("'abc'").kind_of? Ruby::String }
  end

  test "string should return string with left delim" do
    assert { statement("'abc'").left_delim.token == "'" }
  end

  test "string should return string with left delim at correct position" do
    assert { statement("'abc'").left_delim.position == pos(0, 0) }
  end

  test "string should return string with right delim" do
    assert { statement("'abc'").right_delim.token == "'" }
  end

  test "string should return string with right delim at correct position" do
    assert { statement("'abc'").right_delim.position == pos(0, 4) }
  end

  test "string should return string with string contents" do
    assert { statement("'abc'").contents.kind_of? Ruby::StringContents }
  end

  test "string should return string contents with elements" do
    assert { statement("'abc'").contents.elements.kind_of? Array }
  end

  test "string should return string contents with string value" do
    assert { statement("'abc'").contents.first.token == "abc" }
  end

  test "string should return string contents with string value for string that spans lines" do
    assert { statement("'abc\ndef\nghi'").contents.inject("") { |s, l| s << l.token } == "abc\ndef\nghi" }
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

  test "string should return string with string contents for interpolated string" do
    assert { statement('"my #{foo}"').contents.kind_of? Ruby::StringContents }
  end

  test "string should return string with string literal for interpolated string" do
    assert { statement('"my #{foo}"').contents.first.kind_of? Ruby::StringPart }
  end

  test "string should return string with string value for in interpolated string" do
    assert { statement('"my #{foo}"').contents.first.token == "my " }
  end

  test "string should return string with embedded expression for interpolated string" do
    assert { statement('"my #{foo}"').contents.last.kind_of? Ruby::EmbeddedExpression }
  end

  test "string should return string with statement in expression for interpolated string" do
    assert { statement('"my #{foo}"').contents.last.statements.first.token == "foo" }
  end

  test "string should return string with embedded expression with left delimiter for interpolated string" do
    assert { statement('"my #{foo}"').contents.last.left_delim.token == '#{' }
  end

  test "string should return string with embedded expression with right delimiter for interpolated string" do
    assert { statement('"my #{foo}"').contents.last.right_delim.token == '}' }
  end

  test "string should return string with correct statements size in expression for interpolated string" do
    assert { statement('"my #{foo; bar; baz}"').contents.last.statements.size == 3 }
  end
end
