module SyntaxTree
  module Events
    module Lexing
      def create_token(type, token)
        token = Ruby::Token.new token: token, position: position, prologue: prologue
        tokens.push type, token
      end

      def create_token_no_prologue(type, token)
        token = Ruby::Token.new token: token, position: position
        tokens.push type, token
      end

      def create_whitespace(type, token)
        token = Ruby::Whitespace.new token: token, position: position
        tokens.push type, token
      end

      def on_tstring_beg(token)
        create_token :tstring_beg, token
      end

      def on_tstring_end(token)
        create_token :tstring_end, token
      end

      def on_tstring_content(content)
        token = Ruby::Literal.new token: content, position: position
        tokens.push :tstring_content, token
        nil
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

      def on_lbrace(token)
        create_token :lbrace, token
      end

      def on_rbrace(token)
        create_token :rbrace, token
      end

      def on_lparen(token)
        create_token :lparen, token
      end

      def on_rparen(token)
        create_token :rparen, token
      end

      def on_period(token)
        create_token :period, token
      end

      def on_comma(token)
        create_token_no_prologue :comma, token
      end

      def on_semicolon(token)
        create_token_no_prologue :semicolon, token
      end

      def on_op(operator)
        create_token operator.to_sym, operator
      end

      def on_sp(space)
        create_whitespace :sp, space
      end

      def on_nl(newline)
        create_whitespace :nl, newline
      end

      def on_ignored_nl(newline)
        create_whitespace :ignored_nl, newline
      end
    end
  end
end
