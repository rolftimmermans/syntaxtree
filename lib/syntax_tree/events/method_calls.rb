module SyntaxTree
  module Events
    module MethodCalls
      def on_fcall(identifier)
        Ruby::MethodCall.new identifier: identifier
      end

      def on_call(receiver, operator, identifier)
        Ruby::MethodCall.new(
          receiver: receiver,
          operator: tokens.pop(:period, :"::"),
          identifier: identifier)
      end

      def on_command(identifier, arguments)
        Ruby::MethodCall.new(
          identifier: identifier,
          arguments: arguments)
      end

      def on_method_add_arg(method_call, arguments)
        method_call.arguments = arguments
        method_call
      end

      def on_method_add_block(method_call, block)
        method_call.block = block
        method_call
      end

      def on_block_var(parameters, _)
        right_delim, left_delim = tokens.pop(:|), tokens.pop(:|)
        left_delim, right_delim = split_empty_block_delims unless left_delim
        parameters.left_delim, parameters.right_delim = left_delim, right_delim
        parameters
      end

      def on_brace_block(parameters, statements)
        parameters ||= Ruby::ParameterList.new
        Ruby::Block.new(
          left_delim: tokens.pop(:lbrace),
          parameters: parameters,
          statements: statements,
          right_delim: tokens.pop(:rbrace))
      end

      def on_aref(identifier, arguments)
        # args ||= Ruby::ArgumentList.new
        arguments.left_delim = tokens.pop(:lbracket)
        arguments.right_delim = tokens.pop(:rbracket)
        Ruby::MethodCall.new(
          receiver: identifier,
          arguments: arguments)
      end

      protected

      def split_empty_block_delims
        incorrect_operator = tokens.pop(:"||")
        left_delim = Ruby::Token.new(
          token: "|",
          position: incorrect_operator.position,
          prologue: incorrect_operator.prologue)
        right_delim = Ruby::Token.new(
          token: "|",
          position: Ruby::Position.new(incorrect_operator.position.line, incorrect_operator.position.column + 1))
        [left_delim, right_delim]
      end
    end
  end
end
