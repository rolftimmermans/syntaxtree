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

  # Literals
  test "literals should be converted back to ruby" do
    src = "1\n[a, b]\n:foo\n{ :foo => 'bar'}\n?x\n??\n5.65\n1.1\n{ label: 'value'}"
    assert { to_ruby(src) == src }
  end

  # Method calls
  test "method call with arguments should be converted back to ruby" do
    src = "foo_bar(a, 3, :foo)"
    assert { to_ruby(src) == src }
  end

  test "method call with hash arguments should be converted back to ruby" do
    src = "foo_bar!(a, 3, :foo => 3, :bar => 'bar', 4 => nil)"
    assert { to_ruby(src) == src }
  end

  test "method call with receivers should be converted back to ruby" do
    src = "foo.bar(a, 3)"
    assert { to_ruby(src) == src }
  end

  test "method call with const receivers should be converted back to ruby" do
    src = "FooClass.bar(a, 3)"
    assert { to_ruby(src) == src }
  end

  test "method call with const receivers with double colon operator should be converted back to ruby" do
    src = "FooClass::bar(a, 3)"
    assert { to_ruby(src) == src }
  end

  test "method call with empty block should be converted back to ruby" do
    src = "foo.bar(a, 3) { } "
    assert { to_ruby(src) == src }
  end

  test "method call with block with empty parameter list should be converted back to ruby" do
    src = "foo.bar(a, 3) { ||  puts 'foo' } "
    assert { to_ruby(src) == src }
  end

  test "method call with block with parameters should be converted back to ruby" do
    src = "foo.bar(a, 3) { | x , y | puts x } "
    assert { to_ruby(src) == src }
  end

  test "method call with block with regular parameters after optional arguments should be converted back to ruby" do
    src = "foo.bar(a, 3) { |x, y = 3, z|  puts x; } "
    assert { to_ruby(src) == src }
  end

  test "method call with block with all kinds of parameters should be converted back to ruby" do
    src = "foo.bar(a, 3) { |x, y = 3, z = 'foo', *parameters, &block| puts x; puts y\n puts z } "
    assert { to_ruby(src) == src }
  end

  # Class definitions
  test "class definition with semicolons should be converted back to ruby" do
    src = "class Foo;; end"
    assert { to_ruby(src) == src }
  end

  test "class definition with newlines should be converted back to ruby" do
    src = "class Foo\n\nend"
    assert { to_ruby(src) == src }
  end

  test "class definition with superclass should be converted back to ruby" do
    src = "class Foo < Bar\n\nend"
    assert { to_ruby(src) == src }
  end

  test "class definition with namespaced constant should be converted back to ruby" do
    src = "class Foo::Bar::Baz\n\nend"
    assert { to_ruby(src) == src }
  end

  test "class definition with absolutely namespaced constant with whitespaces should be converted back to ruby" do
    src = "class ::Foo::Bar::Baz\n\nend"
    assert { to_ruby(src) == src }
  end

  test "class definition with namespaced constant and superclass should be converted back to ruby" do
    src = "class Foo::Bar::Baz  < Foo::Bar::Qux\n\nfoo\nbar\n\nend"
    assert { to_ruby(src) == src }
  end
end
