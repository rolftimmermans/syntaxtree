module SyntaxTree
  module Events
    module Strings
      def on_string_literal(string)
        string.right_delim = tokens.pop(:tstring_end)
        string
      end

      def on_string_content
        Ruby::String.new left_delim: tokens.pop(:tstring_beg)
      end

      def on_string_add(string, content)
        if content
          string.push content
        else
          string.concat tokens.remove(:tstring_content)
        end
      end
      alias_method :on_xstring_add, :on_string_add

      def on_string_embexpr(statements)
        Ruby::EmbeddedExpression.new statements: statements, left_delim: tokens.pop(:embexpr_beg), right_delim: tokens.pop(:rbrace)
      end

      def on_xstring_new
        typed_token = tokens.pop_typed(:symbeg)
        case typed_token.type
        when :symbeg
          Ruby::DynamicSymbol.new left_delim: typed_token.token
        else raise NotImplementedError, "Unrecognized token #{typed_token.type.inspect}"
        end
      end
    end
  end
end
