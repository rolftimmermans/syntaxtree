require File.expand_path("../test_helper", File.dirname(__FILE__))

class ArrayTest < Test::Unit::TestCase
  context "empty array" do
    subject { statement("[]") }

    should "empty have array" do
      assert { subject.kind_of? Ruby::Array }
    end

    should "empty have array with no elements" do
      assert { subject.elements == [] }
    end
  end

  context "array" do
    subject { statement("[1, 2, 3]") }

    should "be array" do
      assert { subject.kind_of? Ruby::Array }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == "[" }
    end

    should "have right delimiter" do
      assert { subject.right_delim.token == "]" }
    end

    should "have elements" do
      assert { subject.elements.kind_of? Array }
    end

    should "have integers" do
      assert { subject.first.kind_of? Ruby::Integer }
    end

    should "have integers with prologue" do
      assert { subject.last.prologue.to_s == ", " }
    end

    should "have integers without prologue for first element" do
      assert { subject.first.prologue.to_s == "" }
    end

    should "be enumerable" do
      assert { subject.collect.to_a.length == 3 }
    end
  end

  context "array with method calls" do
    should "have method calls with identifiers with prologue" do
      assert { statement("[foo(), bar()]").last.identifier.prologue.to_s == ", " }
    end
  end

  context "array with trailing comma" do
    subject { statement("[1, 2, 3, ]") }

    should "be array" do
      assert { subject.kind_of? Ruby::Array }
    end

    should "have left delimiter with prologue" do
      assert { subject.right_delim.prologue.to_s == ", " }
    end
  end
end
