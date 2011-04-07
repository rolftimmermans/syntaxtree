module SyntaxTree
  module Events
    module Errors
      def on_parse_error(message)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: #{message}")
      end

      def on_class_name_error(identifier)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: class/module name must be CONSTANT")
      end

      def on_alias_error(x)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: can't make alias for the number variables")
      end
    end
  end
end
