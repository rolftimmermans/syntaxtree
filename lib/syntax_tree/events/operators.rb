module SyntaxTree
  module Events
    module Operators
      def on_unary(operator, right)
        # Unary + and - are given as :"+@" and :"-@".
        operator = operator.to_s.chomp("@").to_sym
        Ruby::UnaryOperator.new(
          operator: tokens.pop(operator),
          right: right)
      end

      def on_binary(left, operator, right)
        Ruby::BinaryOperator.new(
          left: left,
          operator: tokens.pop(operator),
          right: right)
      end
    end
  end
end
