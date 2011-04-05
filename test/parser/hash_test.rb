require File.expand_path("../test_helper", File.dirname(__FILE__))

class HashTest < MiniTest::Unit::TestCase
  # Empty hash
  test "empty hash should return hash" do
    assert { statement("{}").kind_of? SyntaxTree::Ruby::Hash }
  end

  test "empty hash should return hash with no elements" do
    assert { statement("{}").elements == [] }
  end

  # Hash
  test "hash should return hash" do
    assert { statement("{ :one => 2 }").kind_of? SyntaxTree::Ruby::Hash }
  end

  test "hash should return hash with left delimiter" do
    assert { statement("{ :one => 2 }").left_delim.token == "{" }
  end

  test "hash should return hash with right delimiter" do
    assert { statement("{ :one => 2 }").right_delim.token == "}" }
  end

  test "hash should return hash with association" do
    assert { statement("{ :one => 2 }").first.kind_of? SyntaxTree::Ruby::Association }
  end

  test "hash should return hash with association with key" do
    assert { statement("{ :one => 2 }").first.key.identifier.token == "one" }
  end

  test "hash should return hash with association with value" do
    assert { statement("{ :one => 2 }").first.value.token == "2" }
  end

  test "hash should return hash with association with operator" do
    assert { statement("{ :one => 2 }").first.operator.token == "=>" }
  end

  test "hash should be enumerable" do
    assert { statement("{ :one => 2, :two => 3 }").collect.to_a.length == 2 }
  end
end
