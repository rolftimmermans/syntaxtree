module SyntaxTree
  module Parser
    class TypedToken
      attr_reader :type, :token

      def initialize(type, token)
        @type, @token = type, token
      end

      def inspect
        @type.inspect
      end
    end

    class TokenStack
      def initialize
        @stack = []
      end

      def push(type, token)
        @stack << TypedToken.new(type, token)
        nil
      end

      def pop(*types)
        popped = pop_typed(*types)
        popped and popped.token
      end

      def remove(*types)
        remove_typed(*types).map(&:token)
      end

      def pop_typed(*types)
        return @stack.pop if types.empty?
        @stack.reverse_each do |token|
          return @stack.delete(token) if types.include? token.type
        end
        nil
      end

      def remove_typed(*types)
        removed, @stack = @stack.partition { |token| types.include? token.type }
        removed
      end

      def size
        @stack.length
      end

      def empty?
        @stack.empty?
      end
      
      def inspect
        @stack.inspect
      end
    end
  end
end
