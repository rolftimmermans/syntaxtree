require "syntax_tree/visitors/base"

module SyntaxTree
  module Visitors
    class ToRuby < Base
      def visit_ruby_node(node)
        node.nodes.each_with_object("") { |node, string| string << visit(node) }
      end

      def visit_string(string)
        string
      end
    end
  end
end
