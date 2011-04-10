module SyntaxTree
  module Events
    module ControlStructures
      def on_if(expression, statements, else_block)
        Ruby::IfStatement.new(
          left_delim: tokens.pop(:if),
          expression: expression,
          statements: statements,
          right_delim: tokens.pop(:end))
      end
    end
  end
end
