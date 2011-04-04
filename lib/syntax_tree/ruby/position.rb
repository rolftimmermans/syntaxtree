module SyntaxTree
  module Ruby
    class Position
      attr_reader :line, :col

      def initialize(line, col)
        @line, @col = line, col
      end

      def ==(other)
        line == other.line and col == other.col
      end

      def inspect
        "(#{line},#{col})"
      end
    end
  end
end
