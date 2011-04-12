module SyntaxTree
  module Events
    module ControlStructures
      def on_if(expression, expressions, else_block)
        expressions.left_delim = tokens.pop(:then)
        Ruby::IfExpression.new(
          left_delim: tokens.pop(:if),
          condition: expression,
          expressions: expressions,
          else: else_block,
          right_delim: tokens.pop(:end))
      end

      def on_unless(expression, expressions, else_block)
        Ruby::UnlessExpression.new(
          left_delim: tokens.pop(:unless),
          condition: expression,
          expressions: expressions,
          else: else_block,
          right_delim: tokens.pop(:end))
      end

      def on_elsif(expression, expressions, else_block)
        Ruby::IfExpression.new(
          left_delim: tokens.pop(:elsif),
          condition: expression,
          expressions: expressions,
          else: else_block)
      end

      def on_else(expressions)
        Ruby::ElseExpression.new(
          left_delim: tokens.pop(:else),
          expressions: expressions)
      end
    end
  end
end
