require File.expand_path("../test_helper", File.dirname(__FILE__))

class ParseErrorTest < Test::Unit::TestCase
  context "namespace operator with spaces" do
    subject { rescuing { parse "class Foo :: Bar; end" } }

    should "raise syntax error" do
      assert { subject.class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { subject.message == "test.rb:1: syntax error, unexpected tCOLON3, expecting '<' or ';' or '\\n'" }
    end
  end

  context "array with only comma" do
    subject { rescuing { parse " [ , ] " } }

    should "raise syntax error" do
      assert { subject.class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { subject.message == "test.rb:1: syntax error, unexpected ',', expecting ']'" }
    end
  end

  context "invalid class name" do
    subject { rescuing { parse "class foo; end" } }

    should "raise syntax error" do
      assert { subject.class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { subject.message == "test.rb:1: class/module name must be CONSTANT" }
    end
  end

  context "invalid alias" do
    subject { rescuing { parse "alias $1 $2" } }

    should "raise syntax error" do
      assert { subject.class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { subject.message == "test.rb:1: can't make alias for the number variables" }
    end
  end
end
