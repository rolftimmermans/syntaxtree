require File.expand_path("../test_helper", File.dirname(__FILE__))

class ToRubyTest < MiniTest::Unit::TestCase
  def to_ruby(src)
    SyntaxTree::Visitors::ToRuby.new.accept SyntaxTree::RubyParser.new(src).parse
  end

  # Trivial programs
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

  # Multiple statements
  test "multiple statements should be converted back to ruby" do
    src = "1\n2\n3"
    assert { to_ruby(src) == src }
  end

  test "multiple statements with semicolons should be converted back to ruby" do
    src = "1; 2;  3"
    assert { to_ruby(src) == src }
  end

  test "multiple method calls should be converted back to ruby" do
    src = "  foo()\n  bar()\n  baz() "
    assert { to_ruby(src) == src }
  end

  test "multiple method calls with semicolons should be converted back to ruby" do
    src = "foo();;  ; bar();  baz() ; "
    assert { to_ruby(src) == src }
  end

  # Method calls
  test "method calls with arguments should be converted back to ruby" do
    src = "foo_bar(a, 3, :foo)"
    assert { to_ruby(src) == src }
  end

  test "method calls with hash arguments should be converted back to ruby" do
    src = "foo_bar!(a, 3, :foo => 3, :bar => 'bar', 4 => nil)"
    assert { to_ruby(src) == src }
  end

  test "method calls with receivers should be converted back to ruby" do
    src = "foo.bar(a, 3)"
    assert { to_ruby(src) == src }
  end

  test "method calls with const receivers should be converted back to ruby" do
    src = "FooClass.bar(a, 3)"
    assert { to_ruby(src) == src }
  end

  test "method calls with const receivers with double colon operator should be converted back to ruby" do
    src = "FooClass::bar(a, 3)"
    assert { to_ruby(src) == src }
  end
end