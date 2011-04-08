module SyntaxTree
  module Events
    module Lexing
      TOKEN_TYPES = [:tstring_beg, :tstring_end, :regexp_beg, :regexp_end,
      :embexpr_beg, :embexpr_end, :lparen, :rparen, :lbrace, :rbrace,
      :lbracket, :rbracket, :symbeg, :period, :embvar]

      TOKEN_TYPES.each do |type|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def on_#{type}(token)
            push_token #{type.inspect}, token
          end
        RUBY
      end

      def on_tstring_content(content)
        token = Ruby::StringPart.new token: content, position: position
        tokens.push :tstring_content, token
      end

      def on_comma(token)
        push_token_no_prologue :comma, token
      end

      def on_semicolon(token)
        push_token_no_prologue :semicolon, token
      end

      def on_op(operator)
        push_token operator.to_sym, operator
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

      def on_comment(comment)
        create_comment :comment, comment
      end
      
      def on_embdoc_beg(comment)
        create_comment :comment, comment
      end

      def on_embdoc(comment)
        create_comment :comment, comment
      end

      def on_embdoc_end(comment)
        create_comment :comment, comment
      end

      private

      def push_token(klass = Ruby::Token, type, token)
        tokens.push type, klass.new(token: token, position: position, prologue: prologue)
      end

      def push_token_no_prologue(type, token)
        token = Ruby::Token.new token: token, position: position
        tokens.push type, token
      end

      def create_whitespace(type, token)
        token = Ruby::Whitespace.new token: token, position: position
        tokens.push type, token
      end

      def create_comment(type, token)
        token = Ruby::Comment.new token: token, position: position
        tokens.push type, token
      end
    end
  end
end
