module SyntaxTree
  module Events
    module Hashes
      def on_hash(associations)
        Ruby::Hash.new(
          left_delim: tokens.pop(:lbrace),
          elements: associations || [],
          right_delim: tokens.pop(:rbrace))
      end

      def on_bare_assoc_hash(associations)
        Ruby::Hash.new elements: associations
      end

      def on_assoclist_from_args(associations)
        associations
      end

      def on_assoc_new(key, value)
        Ruby::Association.new key: key, operator: tokens.pop(:"=>"), value: value
      end
    end
  end
end
