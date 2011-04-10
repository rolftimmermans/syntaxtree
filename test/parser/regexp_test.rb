require File.expand_path("../test_helper", File.dirname(__FILE__))

class RegexpTest < Test::Unit::TestCase
  # Regexp
  test "regexp should return regexp" do
    assert { expression("/abc/").class == Ruby::Regexp }
  end

  test "regexp should return regexp with left delim" do
    assert { expression("/abc/").left_delim.token == "/" }
  end

  test "regexp should return regexp with right delim" do
    assert { expression("/abc/").right_delim.token == "/" }
  end

  test "regexp should return regexp with string contents" do
    assert { expression("/abc/").contents.class == Ruby::StringContents }
  end

  test "regexp should return regexp with string contents with elements" do
    assert { expression("/abc/").contents.elements.kind_of? Array }
  end

  test "regexp should return regexp with string contents with string value" do
    assert { expression("/abc/").contents.first.token == "abc" }
  end

  # Different delimiters
  test "regexp with different delimiters should return regexp" do
    assert { expression("%r{abc}").class == Ruby::Regexp }
  end

  test "regexp with different delimiters should return regexp with left delim" do
    assert { expression("%r{abc}").left_delim.token == "%r{" }
  end

  test "regexp with different delimiters should return regexp with right delim" do
    assert { expression("%r{abc}").right_delim.token == "}" }
  end

  # Modifiers
  test "regexp with modifiers should return regexp" do
    assert { expression("/abc/im").class == Ruby::Regexp }
  end

  test "regexp with modifiers should return regexp with left delim" do
    assert { expression("/abc/im").left_delim.token == "/" }
  end

  test "regexp with modifiers should return regexp with right delim" do
    assert { expression("/abc/im").right_delim.token == "/im" }
  end

  # Multiline
  test "regexp with multiple lines should return regexp" do
    assert { expression("/abc\n[abc]+\n[def]{1,2}/x").class == Ruby::Regexp }
  end

  test "regexp with multiple lines should return string contents with string value" do
    assert { expression("/abc\n[abc]+\n[def]{1,2}/x").contents.inject("") { |s, l| s << l.token } == "abc\n[abc]+\n[def]{1,2}" }
  end

  # Interpolated regexps
  test "regexp should return regexp with left delim for interpolated regexp" do
    assert { expression('/my #{foo}/').left_delim.token == '/' }
  end

  test "regexp should return regexp with right delim for interpolated regexp" do
    assert { expression('/my #{foo}/').right_delim.token == '/' }
  end

  test "regexp should return regexp with regexp contents for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.class == Ruby::StringContents }
  end

  test "regexp should return regexp with regexp literal for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.first.class == Ruby::StringPart }
  end

  test "regexp should return regexp with regexp value for in interpolated regexp" do
    assert { expression('/my #{foo}/').contents.first.token == "my " }
  end

  test "regexp should return regexp with embedded expression for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.last.class == Ruby::EmbeddedExpression }
  end

  test "regexp should return regexp with expression in expression for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.last.expressions.first.token == "foo" }
  end

  test "regexp should return regexp with embedded expression with left delimiter for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.last.left_delim.token == '#{' }
  end

  test "regexp should return regexp with embedded expression with right delimiter for interpolated regexp" do
    assert { expression('/my #{foo}/').contents.last.right_delim.token == '}' }
  end

  test "regexp should return regexp with correct expressions size in expression for interpolated regexp" do
    assert { expression('/my #{foo; bar; baz}/').contents.last.expressions.size == 3 }
  end
end
