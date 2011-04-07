module SyntaxTree
  module Events
    module Operators
      def on_binary(left, operator, right)
        Ruby::BinaryOperator.new(
          left: left,
          operator: tokens.pop(operator),
          right: right)
      end
    end
  end
end
