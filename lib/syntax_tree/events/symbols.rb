module SyntaxTree
  module Events
    module Symbols
      def on_symbol(symbol)
        Ruby::Symbol.new(symbol).tap do |symbol|
          symbol.left_delim = pop_token
        end
      end

      def on_symbol_literal(symbol)
        symbol
      end

      def on_dyna_symbol(symbol)
        symbol.tap do |symbol|
          symbol.right_delim = pop_token
        end
      end
    end
  end
end
