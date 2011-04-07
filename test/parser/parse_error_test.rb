require File.expand_path("../test_helper", File.dirname(__FILE__))

class ParseErrorTest < Test::Unit::TestCase
  context "namespace operator with spaces" do
    subject { rescuing { statement("class Foo :: Bar; end") } }

    should "raise parse error" do
      assert { subject.kind_of? RubyParser::SyntaxError }
    end

    should "raise parse error with correct message" do
      assert { subject.message == "test.rb:1: syntax error, unexpected tCOLON3, expecting '<' or ';' or '\\n'" }
    end
  end
end
