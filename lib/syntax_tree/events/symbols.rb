module SyntaxTree
  module Events
    module Symbols
      def on_symbol(symbol)
        Ruby::Symbol.new identifier: symbol, left_delim: tokens.pop(:symbeg)
      end

      def on_symbol_literal(symbol)
        symbol
      end

      def on_dyna_symbol(symbol)
        symbol.tap do |symbol|
          symbol.right_delim = tokens.pop(:tstring_end)
        end
      end
    end
  end
end
