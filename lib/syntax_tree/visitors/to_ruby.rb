require "syntax_tree/visitors/base"

module SyntaxTree
  module Visitors
    class ToRuby < Base
      def visit_ruby_node(o)
        o.nodes.collect { |node| visit node }.join
      end

      def visit_ruby_token(o)
        o.prologue.to_s + o.token
      end
    end
  end
end
