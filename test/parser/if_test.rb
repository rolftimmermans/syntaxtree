require File.expand_path("../test_helper", File.dirname(__FILE__))

class IfTest < Test::Unit::TestCase
  context "if expression" do
    subject { expression "if foo \n puts 'foo'; puts 'bar' \n end" }

    should_be Ruby::IfExpression
    should_have :condition, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_delimiters "if", "end"
  end

  context "if expression with else" do
    subject { expression "if foo \n puts 'foo'; puts 'bar' \n else puts 'baz'; puts 'qux' \n end" }

    should_be Ruby::IfExpression
    should_have :condition, Ruby::Variable
    should_have_expressions 2
    should_have_delimiters "if", "end"

  end

  context "else block" do
    subject { expression("if foo \n else puts 'baz'; puts 'qux' \n end").else }

    should_be Ruby::ElseExpression
    should_have_expressions 2
    should_have_left_delimiter "else"
  end

  context "elsif block" do
    subject { expression("if foo \n elsif bar \n puts 'foo'; puts 'bar' \n end").else }

    should_be Ruby::IfExpression
    should_have :condition, Ruby::Variable
    should_have_expressions 2
    should_have_left_delimiter "elsif"
  end

  context "unless expression" do
    subject { expression "unless foo \n puts 'foo'; puts 'bar' \n end" }

    should_be Ruby::UnlessExpression
    should_have :condition, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_delimiters "unless", "end"
  end

  context "if expression on single line" do
    subject { expression "if foo then puts 'foo'; puts 'bar' end" }

    should_be Ruby::IfExpression
    should_have :condition, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_expressions_with_left_delimiter "then"
    should_have_delimiters "if", "end"
  end
end
