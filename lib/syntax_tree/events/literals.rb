module SyntaxTree
  module Events
    module Literals
      LITERALS = %w{nil true false}

      def on_kw(keyword)
        if LITERALS.include? keyword
          create_literal(keyword)
        else
          raise NotImplementedError
        end
      end

      def on_int(integer)
        Ruby::Integer.new token: integer, position: position, prologue: prologue
      end

      def on_float(float)
        Ruby::Float.new token: float, position: position, prologue: prologue
      end

      def on_dot2(left, right)
        Ruby::Range.new begin: left, operator: tokens.pop(:".."), end: right
      end

      def on_dot3(left, right)
        Ruby::Range.new begin: left, operator: tokens.pop(:"..."), end: right
      end

      def create_literal(token)
        klass = Ruby.const_get(token[0].upcase + token[1..-1])
        klass.new token: token, position: position, prologue: prologue
      end


      # def on_body_stmt(body, rescue_block, else_block, ensure_block)
      #   statements = [rescue_block, else_block, ensure_block].compact
      #   body = body.to_chained_block(nil, statements) unless statements.empty?
      #   body
      # end
      #
      # def on_paren(node)
      #   node = Ruby::Statements.new(node) unless node.is_a?(Ruby::ArgsList) || node.is_a?(Ruby::Params)
      #   node.rdelim ||= tokens.pop(:@rparen)
      #   node.ldelim ||= tokens.pop(:@lparen)
      #   node
      # end
      #
      # def on_stmts_add(target, statement)
      #   on_words_end if statement.is_a?(Ruby::Array) && !string_stack.empty? # simulating on_words_end event
      #   target.elements << statement if statement
      #   target
      # end
    end
  end
end
