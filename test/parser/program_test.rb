require File.expand_path("../test_helper", File.dirname(__FILE__))

class ProgramTest < MiniTest::Unit::TestCase
  # Empty programs
  test "empty source should return program" do
    assert { parse("").kind_of? SyntaxTree::Ruby::Program }
  end

  test "empty source should return program with statements" do
    assert { parse("").statements.kind_of? SyntaxTree::Ruby::Statements }
  end

  test "empty source should return program with no statements" do
    assert { parse("").statements.elements == [] }
  end

  test "whitespace source should return program" do
    assert { parse("  \n\t ").kind_of? SyntaxTree::Ruby::Program }
  end

  test "whitespace source should return program without statements" do
    assert { parse("  \n\t ").statements.empty? }
  end

  test "whitespace source should return program with epilogue" do
    assert { parse("  \n\t ").epilogue.to_s == "  \n\t " }
  end

  # Identifiers only
  test "identifier should return program with identifier" do
    assert { parse("foo").statements.first.kind_of? SyntaxTree::Ruby::Identifier }
  end

  test "identifiers with semicolumns should return program with identifier" do
    assert { parse("foo; foo").statements.first.kind_of? SyntaxTree::Ruby::Identifier }
  end

  test "identifiers with semicolumns should return program with identifier with prologue" do
    assert { parse("foo; foo").statements.last.prologue.to_s == "; " }
  end

  test "identifiers with multiple semicolumns should return program with identifier with prologue" do
    assert { parse("foo;;; foo").statements.last.prologue.to_s == ";;; " }
  end

  test "identifiers with trailing semicolumns should return program with epilogue" do
    assert { parse("foo; foo ; ").epilogue.to_s == " ; " }
  end
end
