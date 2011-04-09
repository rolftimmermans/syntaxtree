require "graphviz"
require "syntax_tree/visitors/base"

module SyntaxTree
  module Visitors
    class ToDot < Base
      def accept(program)
        @graph = GraphViz.digraph("Ruby", :rankdir => :LR)
        super
        @graph
      end

      protected

      def visit_ruby_node(node)
        add_node(node).tap do |current|
          node.class.node_names.each do |name|
            child = node.send(name)
            if child.class == Array
              graph_child = add_elements_node(child)
              child.each do |element|
                add_edge graph_child, visit(element)
              end
              add_edge(current, graph_child, name, "none")
            elsif child and child.class != SyntaxTree::Ruby::Prologue and child.class != SyntaxTree::Ruby::Epilogue
              add_edge(current, visit(child), name)
            end
          end
        end
      end

      def visit_string(token)
        add_token_node token
      end

      private

      def add_node(node)
        @graph.add_node node.object_id.to_s,
          label: node.class.name.gsub("SyntaxTree::Ruby::", ""),
          fontname: "Arial Bold",
          fontsize: 11
      end

      def add_elements_node(array)
        @graph.add_node array.object_id.to_s,
          shape: "circle",
          label: nil,
          style: "filled",
          color: "black",
          height: 0.1,
          width: 0.1
      end

      def add_token_node(node)
        @graph.add_node node.object_id.to_s,
          label: node,
          shape: "box",
          fontname: "Menlo",
          fontsize: 10
      end

      def add_edge(from, to, label = nil, arrowhead = "normal")
        @graph.add_edge from, to,
          label: label,
          fontname: "Arial",
          fontsize: 10,
          arrowhead: arrowhead
      end
    end
  end
end
