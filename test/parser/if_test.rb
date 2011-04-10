require File.expand_path("../test_helper", File.dirname(__FILE__))

class IfTest < Test::Unit::TestCase
  context "if without else" do
    subject { statement "if foo \n puts 'foo'; puts 'bar' \n end" }

    should_be Ruby::IfStatement
    should_have_child_of_class :expression, Ruby::Variable
    should_have_statements 2
    should_have_delimiters "if", "end"
  end
end
