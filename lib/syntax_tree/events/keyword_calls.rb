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

      def on_next(arguments)
        Ruby::KeywordCall.new keyword: tokens.pop(:next), arguments: arguments
      end

      def on_break(arguments)
        Ruby::KeywordCall.new keyword: tokens.pop(:break), arguments: arguments
      end

      def on_redo
        Ruby::KeywordCall.new keyword: tokens.pop(:redo)
      end

      def on_retry
        Ruby::KeywordCall.new keyword: tokens.pop(:retry)
      end

      def on_BEGIN(statements)
        # We pretend that the argument to BEGIN/END is a block, which it
        # technically isn't (e.g. do/end does not work, it requires braces).
        Ruby::KeywordCall.new(
          keyword: tokens.pop(:BEGIN, :END),
          block: Ruby::Block.new(
            left_delim: tokens.pop(:lbrace),
            statements: statements,
            right_delim: tokens.pop(:rbrace)))
      end
      alias_method :on_END, :on_BEGIN
    end
  end
end
