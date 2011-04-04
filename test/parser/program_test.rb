require File.expand_path("../test_helper", File.dirname(__FILE__))

class ProgramTest < MiniTest::Unit::TestCase
  test "empty source should return program" do
    assert { parse("").kind_of? SyntaxTree::Ruby::Program }
  end

  test "empty source should return program with statements" do
    assert { parse("").statements.kind_of? SyntaxTree::Ruby::Statements }
  end

  test "empty source should return program with no statements" do
    assert { parse("").statements.elements == [] }
  end
end
