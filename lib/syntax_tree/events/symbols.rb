module SyntaxTree
  module Events
    module Symbols
      def on_symbol(symbol)
        Ruby::Symbol.new identifier: symbol, left_delim: tokens.pop(:symbeg)
      end

      def on_symbol_literal(symbol)
        symbol
      end

      def on_dyna_symbol(contents)
        Ruby::DynamicSymbol.new(
          left_delim: tokens.pop(:symbeg),
          contents: contents,
          right_delim: tokens.pop(:tstring_end))
      end
    end
  end
end
