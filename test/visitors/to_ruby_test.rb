require File.expand_path("../test_helper", File.dirname(__FILE__))

class ToRubyTest < MiniTest::Unit::TestCase
  def to_ruby(src)
    SyntaxTree::Visitors::ToRuby.new.accept SyntaxTree::RubyParser.new(src).parse
  end

  test "trivial statement should be converted back to ruby" do
    src = "nil"
    assert { to_ruby(src) == src }
  end

  test "trivial statement with whitespace should be converted back to ruby" do
    src = "\t  nil"
    assert { to_ruby(src) == src }
  end

  test "trivial statement with trailing whitespace should be converted back to ruby" do
    src = "  nil \t  "
    assert { to_ruby(src) == src }
  end

  test "multiple statements should be converted back to ruby" do
    src = "1\n2\n3"
    assert { to_ruby(src) == src }
  end

  test "multiple statements with semicolons should be converted back to ruby" do
    src = "1; 2;  3"
    assert { to_ruby(src) == src }
  end
end
