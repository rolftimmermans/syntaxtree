require File.expand_path("../test_helper", File.dirname(__FILE__))

class RegexpTest < Test::Unit::TestCase
  # Regexp
  test "regexp should return regexp" do
    assert { statement("/abc/").kind_of? Ruby::Regexp }
  end

  test "regexp should return regexp with left delim" do
    assert { statement("/abc/").left_delim.token == "/" }
  end

  test "regexp should return regexp with right delim" do
    assert { statement("/abc/").right_delim.token == "/" }
  end

  test "regexp should return regexp with string contents" do
    assert { statement("/abc/").contents.kind_of? Ruby::StringContents }
  end

  test "regexp should return regexp with string contents with elements" do
    assert { statement("/abc/").contents.elements.kind_of? Array }
  end

  test "regexp should return regexp with string contents with string value" do
    assert { statement("/abc/").contents.first.token == "abc" }
  end

  # Different delimiters
  test "regexp with different delimiters should return regexp" do
    assert { statement("%r{abc}").kind_of? Ruby::Regexp }
  end

  test "regexp with different delimiters should return regexp with left delim" do
    assert { statement("%r{abc}").left_delim.token == "%r{" }
  end

  test "regexp with different delimiters should return regexp with right delim" do
    assert { statement("%r{abc}").right_delim.token == "}" }
  end

  # Modifiers
  test "regexp with modifiers should return regexp" do
    assert { statement("/abc/im").kind_of? Ruby::Regexp }
  end

  test "regexp with modifiers should return regexp with left delim" do
    assert { statement("/abc/im").left_delim.token == "/" }
  end

  test "regexp with modifiers should return regexp with right delim" do
    assert { statement("/abc/im").right_delim.token == "/im" }
  end

  # Multiline
  test "regexp with multiple lines should return regexp" do
    assert { statement("/abc\n[abc]+\n[def]{1,2}/x").kind_of? Ruby::Regexp }
  end

  test "regexp with multiple lines should return string contents with string value" do
    assert { statement("/abc\n[abc]+\n[def]{1,2}/x").contents.inject("") { |s, l| s << l.token } == "abc\n[abc]+\n[def]{1,2}" }
  end

  # Interpolated regexps
  test "regexp should return regexp with left delim for interpolated regexp" do
    assert { statement('/my #{foo}/').left_delim.token == '/' }
  end

  test "regexp should return regexp with right delim for interpolated regexp" do
    assert { statement('/my #{foo}/').right_delim.token == '/' }
  end

  test "regexp should return regexp with regexp contents for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.kind_of? Ruby::StringContents }
  end

  test "regexp should return regexp with regexp literal for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.first.kind_of? Ruby::StringPart }
  end

  test "regexp should return regexp with regexp value for in interpolated regexp" do
    assert { statement('/my #{foo}/').contents.first.token == "my " }
  end

  test "regexp should return regexp with embedded expression for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.last.kind_of? Ruby::EmbeddedExpression }
  end

  test "regexp should return regexp with statement in expression for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.last.statements.first.token == "foo" }
  end

  test "regexp should return regexp with embedded expression with left delimiter for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.last.left_delim.token == '#{' }
  end

  test "regexp should return regexp with embedded expression with right delimiter for interpolated regexp" do
    assert { statement('/my #{foo}/').contents.last.right_delim.token == '}' }
  end

  test "regexp should return regexp with correct statements size in expression for interpolated regexp" do
    assert { statement('/my #{foo; bar; baz}/').contents.last.statements.size == 3 }
  end
end
