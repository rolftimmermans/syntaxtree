require File.expand_path("../test_helper", File.dirname(__FILE__))

class HashTest < Test::Unit::TestCase
  context "empty hash" do
    subject { statement("{}") }

    should "be hash" do
      assert { subject.kind_of? Ruby::Hash }
    end

    should "have no elements" do
      assert { subject.elements.empty? }
    end
  end

  context "hash" do
    subject { statement("{ :one => 2, :two => 3 }") }

    should "be hash" do
      assert { subject.kind_of? Ruby::Hash }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == "{" }
    end

    should "have right delimiter" do
      assert { subject.right_delim.token == "}" }
    end

    should "have association" do
      assert { subject.first.kind_of? Ruby::Association }
    end

    should "have association with key" do
      assert { subject.first.key.identifier.token == "one" }
    end

    should "have association with value" do
      assert { subject.first.value.token == "2" }
    end

    should "have association with operator" do
      assert { subject.first.operator.token == "=>" }
    end

    should "be enumerable" do
      assert { subject.collect.to_a.length == 2 }
    end
  end
end
