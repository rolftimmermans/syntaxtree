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
        arguments.push Ruby::BlockArgument.new identifier: block, left_delim: tokens.pop(:"&") if block
        arguments
      end

      def on_args_add_star(arguments, argument)
        arguments.push Ruby::SplatArgument.new identifier: argument, left_delim: tokens.pop(:"*")
        arguments
      end
    end
  end
end
