module SyntaxTree
  module Events
    module Errors
      def on_parse_error(message)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: #{message}")
      end

      def on_class_name_error(identifier)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: class/module name must be CONSTANT")
      end

      def on_alias_error(_)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: can't make alias for the number variables")
      end

      def on_param_error(identifier)
        raise RubyParser::SyntaxError.new("#{file}:#{position.line + 1}: formal argument cannot be an instance variable")
      end

      def on_operator_ambiguous(operator, operator_type_description)
        # Omit warning: `operator' after local variable is interpreted as binary operator
      end

      def on_arg_ambiguous
        # Omit warning: ambiguous first argument; put parentheses or even spaces
      end
    end
  end
end
