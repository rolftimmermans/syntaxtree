require "syntax_tree/visitors/base"

module SyntaxTree
  module Visitors
    class ToRuby < Base
      def visit_ruby_program(o)
        visit o.statements
      end

      def visit_each(o)
        o.collect { |node| visit node }.join
      end
      alias_method :visit_ruby_statements, :visit_each
      alias_method :visit_ruby_prologue, :visit_each

      def visit_ruby_token(o)
        o.prologue.to_s + o.token
      end
    end
  end
end
