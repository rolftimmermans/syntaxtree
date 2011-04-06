module SyntaxTree
  module Events
    module Strings
      def on_string_literal(contents)
        Ruby::String.new(
          left_delim: tokens.pop(:tstring_beg),
          contents: contents,
          right_delim: tokens.pop(:tstring_end))
      end

      def on_regexp_literal(contents, _)
        Ruby::Regexp.new(
          left_delim: tokens.pop(:regexp_beg),
          contents: contents,
          right_delim: tokens.pop(:regexp_end))
      end

      def on_string_content
        Ruby::StringContents.new
      end
      alias_method :on_xstring_new, :on_string_content
      alias_method :on_regexp_new, :on_string_content

      def on_string_add(string, content)
        if content
          string.push content
        else
          string.concat tokens.remove(:tstring_content)
        end
      end
      alias_method :on_xstring_add, :on_string_add
      alias_method :on_regexp_add, :on_string_add

      def on_string_embexpr(statements)
        Ruby::EmbeddedExpression.new statements: statements, left_delim: tokens.pop(:embexpr_beg), right_delim: tokens.pop(:rbrace)
      end
    end
  end
end
