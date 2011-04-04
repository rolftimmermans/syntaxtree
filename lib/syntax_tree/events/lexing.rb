module SyntaxTree
  module Events
    module Lexing
      def create_token(type, token)
        token = Ruby::Token.new(token, position).tap do |token|
          token.prologue = collect_prologue
        end
        push_token type, token
      end

      def on_tstring_beg(token)
        create_token :tstring_beg, token
      end

      def on_tstring_end(token)
        create_token :tstring_end, token
      end

      def on_embexpr_beg(token)
        create_token :embexpr_beg, token
      end

      def on_embexpr_end(token)
        create_token :embexpr_end, token
      end

      def on_rbrace(token)
        create_token :rbrace, token
      end

      def on_symbeg(token)
        create_token :symbeg, token
      end

      def on_lbracket(token)
        create_token :lbracket, token
      end

      def on_rbracket(token)
        create_token :rbracket, token
      end

      def on_comma(token)
        create_token :comma, token
      end

      def on_op(operator)
        create_token operator.to_sym, operator
      end

      def on_sp(space)
        push_prologue Ruby::Whitespace.new(space, position)
      end
    end
  end
end
