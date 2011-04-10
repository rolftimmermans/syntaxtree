module SyntaxTree
  module Events
    module Expressions
      def on_program(expressions)
        Ruby::Program.new source: source, file: file, expressions: expressions, epilogue: epilogue
      end

      def on_magic_comment(key, somehow_always_false)
        # Ignore magic comments; they appear as comment token anyway.
      end

      def on_paren(node)
        # node = Ruby::ExpressionList.new(node) unless node.is_a?(Ruby::ArgsList) || node.is_a?(Ruby::Params)
        # node.rdelim ||= tokens.pop(:@rparen)
        # node.ldelim ||= tokens.pop(:@lparen)
        node.left_delim = tokens.pop(:lparen)
        node.right_delim = tokens.pop(:rparen)
        node
      end

      def on_stmts_new
        Ruby::ExpressionList.new
      end

      def on_stmts_add(expressions, expression)
        expressions.push expression
        expressions
      end

      def on_void_stmt
        nil
      end

      def on_bodystmt(body, rescue_block, else_block, ensure_block)
        # p body
        # p rescue_block
        # p else_block
        # p ensure_block
        #
        body
      end

      def on_var_ref(reference)
        if reference.class == Ruby::Identifier
          Ruby::Variable.new(
            token: reference.token,
            position: reference.position,
            prologue: reference.prologue)
        else
          reference
        end
      end

      def on_const_ref(reference)
        reference
      end

      def on_alias(aliased, original)
        Ruby::Alias.new(
          keyword: tokens.pop(:alias),
          alias: aliased,
          original: original)
      end
      alias_method :on_var_alias, :on_alias

      # def on_body_stmt(body, rescue_block, else_block, ensure_block)
      #   expressions = [rescue_block, else_block, ensure_block].compact
      #   body = body.to_chained_block(nil, expressions) unless expressions.empty?
      #   body
      # end
      #
      #
      # def on_stmts_add(target, expression)
      #   on_words_end if expression.is_a?(Ruby::Array) && !string_stack.empty? # simulating on_words_end event
      #   target.elements << expression if expression
      #   target
      # end
    end
  end
end
