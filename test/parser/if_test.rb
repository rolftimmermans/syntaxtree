require File.expand_path("../test_helper", File.dirname(__FILE__))

class IfTest < Test::Unit::TestCase
  context "if statement" do
    subject { statement "if foo \n puts 'foo'; puts 'bar' \n end" }

    should_be Ruby::IfExpression
    should_have :expression, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_delimiters "if", "end"
  end

  context "if statement with else" do
    subject { statement "if foo \n puts 'foo'; puts 'bar' \n else puts 'baz'; puts 'qux' \n end" }

    should_be Ruby::IfExpression
    should_have :expression, Ruby::Variable
    should_have_expressions 2
    should_have_delimiters "if", "end"

  end

  context "else block" do
    subject { statement("if foo \n else puts 'baz'; puts 'qux' \n end").else }

    should_be Ruby::ElseExpression
    should_have_expressions 2
    should_have_left_delimiter "else"
  end

  context "elsif block" do
    subject { statement("if foo \n elsif bar \n puts 'foo'; puts 'bar' \n end").else }

    should_be Ruby::IfExpression
    should_have :expression, Ruby::Variable
    should_have_expressions 2
    should_have_left_delimiter "elsif"
  end

  context "unless statement" do
    subject { statement "unless foo \n puts 'foo'; puts 'bar' \n end" }

    should_be Ruby::UnlessExpression
    should_have :expression, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_delimiters "unless", "end"
  end

  context "if statement on single line" do
    subject { statement "if foo then puts 'foo'; puts 'bar' end" }

    should_be Ruby::IfExpression
    should_have :expression, Ruby::Variable
    should_not_have :else
    should_have_expressions 2
    should_have_expressions_with_left_delimiter "then"
    should_have_delimiters "if", "end"
  end
end
