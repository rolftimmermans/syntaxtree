require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyTest < Test::Unit::TestCase
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
end
