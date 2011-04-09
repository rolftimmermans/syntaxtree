require File.expand_path("../../test_helper", File.dirname(__FILE__))

class BaseVisitorTest < Test::Unit::TestCase
  context "base" do
    subject { Class.new(Visitors::Base) { attr_reader :visited }.new }

    should "should accept node if implemented" do
      class << subject
        def visit_ruby_dynamic_symbol(node)
          @visited = true
        end
      end
      subject.accept parse(":'foo'").statements.first
      assert { subject.visited == true }
    end

    should "should accept node if implemented for superclass" do
      class << subject
        def visit_ruby_node(node)
          @visited = true
        end
      end
      subject.accept parse("foo").statements.first
      assert { subject.visited == true }
    end

    should "should accept string if implemented" do
      class << subject
        def visit_string(node)
          @visited = true
        end
      end
      subject.accept "foo"
      assert { subject.visited == true }
    end

    should "should not accept node if unimplemented" do
      assert { rescuing { subject.accept parse("foo") }.class == TypeError }
    end
  end
end
