module SyntaxTree
  module Events
    module Strings
      def on_string_literal(string)
        string.right_delim = pop_token
        string
      end

      def on_string_content
        Ruby::String.new.tap do |string|
          string.left_delim = pop_token
        end
      end

      def on_tstring_content(content)
        push_string Ruby::Literal.new(content, position)
        nil
      end

      def on_string_add(string, content)
        if content
          string.push content
        else
          string.concat collect_string
        end
      end
      alias_method :on_xstring_add, :on_string_add

      def on_string_embexpr(statements)
        Ruby::EmbeddedExpression.new statements: statements, right_delim: pop_token, left_delim: pop_token
      end

      def on_xstring_new
        type, token = pop_typed_token(:symbeg)
        case type
        when :symbeg
          Ruby::DynamicSymbol.new.tap do |symbol|
            symbol.left_delim = token
          end
        else raise NotImplementedError, "Unrecognized token #{type.inspect}"
        end
      end
    end
  end
end
