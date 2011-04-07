require File.expand_path("../test_helper", File.dirname(__FILE__))

class ParseErrorTest < Test::Unit::TestCase
  def parse_error(code)
    rescuing { parse code }
  end

  def parse_message(code)
    parse_error(code).message
  end

  def eval_error(code)
    rescuing { eval code, binding, "test.rb", 1 }
  end

  def eval_message(code)
    eval_error(code).message.split("\n").first
  end

  context "namespace operator with spaces" do
    subject { "class Foo :: Bar; end" }

    should "raise syntax error" do
      assert { parse_error(subject).class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { parse_message(subject) == eval_message(subject) }
    end
  end

  context "array with only comma" do
    subject { " [ , ] " }

    should "raise syntax error" do
      assert { parse_error(subject).class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { parse_message(subject) == eval_message(subject) }
    end
  end

  context "invalid class name" do
    subject { "class foo; end" }

    should "raise syntax error" do
      assert { parse_error(subject).class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { parse_message(subject) == eval_message(subject) }
    end
  end

  context "invalid alias" do
    subject { "alias $1 $2" }

    should "raise syntax error" do
      assert { parse_error(subject).class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { parse_message(subject) == eval_message(subject) }
    end
  end

  context "invalid parameter type" do
    subject { "foo { |@bar| }" }

    should "raise syntax error" do
      assert { parse_error(subject).class == RubyParser::SyntaxError }
    end

    should "raise syntax error with correct message" do
      assert { parse_message(subject) == eval_message(subject) }
    end
  end

  context "ambiguous operator" do
    subject { "3 +1" }

    should "not raise syntax error" do
      assert { parse_error(subject) == nil }
    end
  end

  context "ambiguous argument" do
    subject { "puts /m/, 42" }

    should "not raise syntax error" do
      assert { parse_error(subject) == nil }
    end
  end
end
