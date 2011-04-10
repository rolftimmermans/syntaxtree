module SyntaxTree
  module Events
    module Literals
      def on_dot2(left, right)
        Ruby::Range.new begin: left, operator: tokens.pop(:".."), end: right
      end

      def on_dot3(left, right)
        Ruby::Range.new begin: left, operator: tokens.pop(:"..."), end: right
      end

      def on_array(argument_list)
        Ruby::Array.new(
          left_delim: tokens.pop(:lbracket),
          elements: argument_list ? argument_list.elements : [],
          right_delim: tokens.pop(:rbracket))
      end

      # def on_body_stmt(body, rescue_block, else_block, ensure_block)
      #   expressions = [rescue_block, else_block, ensure_block].compact
      #   body = body.to_chained_block(nil, expressions) unless expressions.empty?
      #   body
      # end
      #
      # def on_paren(node)
      #   node = Ruby::ExpressionList.new(node) unless node.is_a?(Ruby::ArgsList) || node.is_a?(Ruby::Params)
      #   node.rdelim ||= tokens.pop(:@rparen)
      #   node.ldelim ||= tokens.pop(:@lparen)
      #   node
      # end
      #
      # def on_stmts_add(target, expression)
      #   on_words_end if expression.is_a?(Ruby::Array) && !string_stack.empty? # simulating on_words_end event
      #   target.elements << expression if expression
      #   target
      # end
    end
  end
end
