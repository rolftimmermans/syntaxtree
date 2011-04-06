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
    end
  end
end
