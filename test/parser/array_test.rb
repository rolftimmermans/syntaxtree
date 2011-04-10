require File.expand_path("../test_helper", File.dirname(__FILE__))

class ArrayTest < Test::Unit::TestCase
  context "empty array" do
    subject { expression "[]" }

    should_be Ruby::Array

    should "empty have array with no elements" do
      assert { subject.elements == [] }
    end
  end

  context "array" do
    subject { expression "[1, 2, 3]" }

    should_be Ruby::Array
    should_have_delimiters "[", "]"
    should_have :elements, Array
    should_have :first, Ruby::Integer

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
    subject { expression "[foo(), bar()]" }

    should "have identifiers with prologue" do
      assert { subject.last.identifier.prologue.to_s == ", " }
    end
  end

  context "array with trailing comma" do
    subject { expression "[1, 2, 3, ]" }

    should_be Ruby::Array

    should "have left delimiter with prologue" do
      assert { subject.right_delim.prologue.to_s == ", " }
    end
  end
end
