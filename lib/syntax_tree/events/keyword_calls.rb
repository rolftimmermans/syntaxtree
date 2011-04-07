module SyntaxTree
  module Events
    module KeywordCalls
      def on_zsuper
        Ruby::KeywordCall.new keyword: tokens.pop(:super)
      end

      def on_super(arguments)
        Ruby::KeywordCall.new keyword: tokens.pop(:super), arguments: arguments
      end

      def on_yield0
        Ruby::KeywordCall.new keyword: tokens.pop(:yield)
      end

      def on_yield(arguments)
        Ruby::KeywordCall.new keyword: tokens.pop(:yield), arguments: arguments
      end

      def on_return0
        Ruby::KeywordCall.new keyword: tokens.pop(:return)
      end

      def on_return(arguments)
        Ruby::KeywordCall.new keyword: tokens.pop(:return), arguments: arguments.first
      end
    end
  end
end
