require File.expand_path("../test_helper", File.dirname(__FILE__))

class NodeHierarchyTest < MiniTest::Unit::TestCase
  include SyntaxTree::Ruby

  def construct_hierarchy(root = SyntaxTree::Ruby::Node)
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

  test "hierarchy should be sensible" do
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

        Class => {},
        MethodCall => {},
        Block => {},

        SplatArgument => {},
        BlockArgument => {},

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

        Token => { # Leaf nodes
          StringPart => {},
          Keyword => {
            False => {},
            True => {},
            Nil => {}
          },
          Literal => {
            Character => {},
            Float => {},
            Integer => {},
            Label => {}
          },
          Identifier => {
            Constant => {}
          },
          Whitespace => {},
        }
      }
    })
    actual_hierarchy = sort(construct_hierarchy)
    assert { actual_hierarchy == expected_hierarchy }
  end

  # test "node tree should be readable" do
  #   tree = parse("class Foo; end").inspect
  #   puts tree
  #   expected_inspect = ""
  #   assert { tree == expected_inspect }
  # end
end
