module SyntaxTree
  module Ruby
    class Position
      attr_reader :line, :column

      def initialize(line, column)
        @line, @column = line, column
      end

      def ==(other)
        line == other.line and column == other.column
      end

      def to_s
        "(#{line},#{column})"
      end
    end
  end
end
