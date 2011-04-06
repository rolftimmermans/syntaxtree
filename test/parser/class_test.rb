require File.expand_path("../test_helper", File.dirname(__FILE__))

class ClassTest < MiniTest::Unit::TestCase
  # Class
  test "class should return class" do
    assert { statement("class Foo; end").kind_of? SyntaxTree::Ruby::Class }
  end

  test "class should return class with left delimiter" do
    assert { statement("class Foo; end").left_delim.token == "class" }
  end

  test "class should return class with right delimiter" do
    assert { statement("class Foo; end").right_delim.token == "end" }
  end

  test "class should return class with constant identifier" do
    assert { statement("class Foo; end").identifier.kind_of? SyntaxTree::Ruby::Constant }
  end

  test "class should return class with constant identifier with given name" do
    assert { statement("class Foo; end").identifier.token == "Foo" }
  end

  test "class should return class with statements attribute" do
    assert { statement("class Foo; end").statements.kind_of? SyntaxTree::Ruby::Statements }
  end

  test "class should return class with no statements" do
    assert { statement("class Foo; end").statements.elements == [] }
  end

  test "class should return class without operator" do
    assert { statement("class Foo; end").operator == nil }
  end

  test "class should return class without superclass" do
    assert { statement("class Foo; end").superclass == nil }
  end

  # Class with statements
  test "class with statements should return class" do
    assert { statement("class Foo; define_foo; end").kind_of? SyntaxTree::Ruby::Class }
  end

  test "class with statements should return class with statements attribute" do
    assert { statement("class Foo; define_foo; end").statements.kind_of? SyntaxTree::Ruby::Statements }
  end

  test "class with statements should return class with statements" do
    assert { statement("class Foo; define_foo; end").statements.first.kind_of? SyntaxTree::Ruby::Identifier }
  end

  test "class with statements should return class correct statement length" do
    assert { statement("class Foo; define_foo; define_bar; 3; end").statements.size == 3 }
  end

  # Child class
  test "child class should return class" do
    assert { statement("class Foo < Bar; end").kind_of? SyntaxTree::Ruby::Class }
  end

  test "child class should return class with superclass" do
    assert { statement("class Foo < Bar; end").superclass.kind_of? SyntaxTree::Ruby::Constant }
  end

  test "child class should return class with superclass with correct token" do
    assert { statement("class Foo < Bar; end").superclass.token == "Bar" }
  end

  test "child class should return class with operator" do
    assert { statement("class Foo < Bar; end").operator.token == "<" }
  end

  # Class with namespace
  test "namespaced class should return class" do
    assert { statement("class Foo::Bar; end").kind_of? SyntaxTree::Ruby::Class }
  end

  test "namespaced class should return class with namespace" do
    assert { statement("class Foo::Bar; end").identifier.kind_of? SyntaxTree::Ruby::Namespace }
  end

  test "namespaced class should return class with namespace with constant" do
    assert { statement("class Foo::Bar; end").identifier.first.kind_of? SyntaxTree::Ruby::Constant }
  end

  test "namespaced class should return class with namespace with constant names" do
    assert { statement("class Foo::Bar; end").identifier.map(&:token) == ["Foo", "Bar"] }
  end

  test "deeply namespaced class should return class with namespace with last constant name" do
    assert { statement("class Foo::Bar::Baz::Qux; end").identifier.map(&:token) == ["Foo", "Bar", "Baz", "Qux"] }
  end
end
