require File.expand_path("../test_helper", File.dirname(__FILE__))

class NodeHierarchyTest < Test::Unit::TestCase
  include Ruby

  def construct_hierarchy(root = Ruby::Node)
    nodes = []
    tree = {}
    ObjectSpace.each_object(::Class) do |klass|
      next unless klass.ancestors.include? root
      next if nodes.include? klass
      nodes << klass
      ancestor_nodes = klass.ancestors.select { |n| n.name =~ /^SyntaxTree/ and n.kind_of? ::Class }
      ancestor_nodes.reverse.inject(tree) { |memo, klass| memo[klass] ||= {} }
    end
    tree
  end

  def sort(hierarchy)
    hierarchy.deep_sort { |one, other| one[0].name <=> other[0].name }
  end

  context "hierarchy" do
    subject { sort(construct_hierarchy) }

    should "be sensible" do
      expected_hierarchy = sort({
        Node => { # Abstract
          Composite => { # Enumerable
            Epilogue => {},
            Prologue => {},

            Statements => {},
            Hash => {},
            Array => {},
            ArgumentList => {},
            ParameterList => {},
            StringContents => {},
            Namespace => {},
          },

          Program => {}, # Root node

          Class => {
            MetaClass => {}
          },
          Module => {},
          Block => {},

          MethodCall => {},
          SplatArgument => {},
          BlockArgument => {},

          MethodDefinition => {},
          DefaultParameter => {},
          SplatParameter => {},
          BlockParameter => {},

          Symbol => {},
          DynamicSymbol => {},
          String => {},
          Regexp => {},
          EmbeddedExpression => {},
          Range => {},
          Association => {},

          BinaryOperator => {},

          Token => { # Leaf nodes
            StringPart => {},
            Keyword => {
              False => {},
              True => {},
              Nil => {},
              Self => {}
            },
            Literal => {
              Character => {},
              Float => {},
              Integer => {},
              Label => {}
            },
            Identifier => {
              Constant => {},
              Variable => {},
              InstanceVariable => {},
              ClassVariable => {},
              GlobalVariable => {}
            },
            Whitespace => {},
          }
        }
      })
      assert { subject == expected_hierarchy }
    end
  end
end
