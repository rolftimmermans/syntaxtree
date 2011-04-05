module SyntaxTree
  module Events
    module MethodCalls
      def on_fcall(identifier)
        Ruby::MethodCall.new identifier: identifier
      end

      def on_call(receiver, operator, identifier)
        Ruby::MethodCall.new receiver: receiver, operator: tokens.pop(:period, :"::"), identifier: identifier
      end
    end
  end
end
