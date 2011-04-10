module SyntaxTree
  module Events
    module ControlStructures
      def on_if(expression, statements, else_block)
        statements.left_delim = tokens.pop(:then)
        Ruby::IfExpression.new(
          left_delim: tokens.pop(:if),
          expression: expression,
          statements: statements,
          else: else_block,
          right_delim: tokens.pop(:end))
      end

      def on_unless(expression, statements, else_block)
        Ruby::UnlessExpression.new(
          left_delim: tokens.pop(:unless),
          expression: expression,
          statements: statements,
          else: else_block,
          right_delim: tokens.pop(:end))
      end

      def on_elsif(expression, statements, else_block)
        Ruby::IfExpression.new(
          left_delim: tokens.pop(:elsif),
          expression: expression,
          statements: statements,
          else: else_block)
      end

      def on_else(statements)
        Ruby::ElseExpression.new(
          left_delim: tokens.pop(:else),
          statements: statements)
      end
    end
  end
end
