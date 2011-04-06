require File.expand_path("../test_helper", File.dirname(__FILE__))

class ParseErrorTest < MiniTest::Unit::TestCase
  # Namespaces
  test "namespace operator with spaces should raise parse error" do
    assert { rescuing { statement("class Foo :: Bar; end") }.kind_of? SyntaxTree::RubyParser::SyntaxError }
  end

  test "namespace operator with spaces should raise parse error with correct message" do
    assert { rescuing { statement("class Foo :: Bar; end") }.message == "test.rb:1: syntax error, unexpected tCOLON3, expecting '<' or ';' or '\\n'" }
  end
end
