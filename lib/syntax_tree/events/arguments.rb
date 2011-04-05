module SyntaxTree
  module Events
    module Arguments
      def on_args_new
        Ruby::ArgumentList.new
      end

      def on_args_add(arguments, argument)
        arguments.push argument
        arguments
      end

      def on_arg_paren(arguments)
        arguments ||= Ruby::ArgumentList.new
        arguments.right_delim = tokens.pop(:rparen)
        arguments.left_delim = tokens.pop(:lparen)
        arguments
      end

      def on_args_add_block(arguments, block)
        arguments.push Ruby::BlockArgument.new block: block if block
        arguments
      end

      def on_method_add_arg(method_call, arguments)
        method_call.arguments = arguments
        method_call
      end
    end
  end
end
