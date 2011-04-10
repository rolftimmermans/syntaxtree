require "syntax_tree/ruby/node"
require "syntax_tree/ruby/node/prologued"

module SyntaxTree
  module Ruby
    class Token < Node
      define_nodes :token  # FIXME: Rename to :lexeme

      attr_accessor :position

      include Prologued
    end


    class Glyph < Token
    end

    class StringPart < Token
    end

    class Whitespace < Token
    end

    class Comment < Token
    end


    class Keyword < Token
    end

    class False < Keyword
      def value
        false
      end
    end

    class Nil < Keyword
      def value
        nil
      end
    end

    class Self < Keyword
    end

    class True < Keyword
      def value
        true
      end
    end


    class Literal < Token
    end

    class Character < Literal
      def value
        token[1].chr
      end
    end

    class Float < Literal
      def value
        token.to_f
      end
    end

    class Integer < Literal
      def value
        token.to_i
      end
    end

    class Label < Literal
      def value
        token.chop.to_sym
      end
    end


    class Identifier < Token
    end

    class ClassVariable < Identifier
    end

    class Constant < Identifier
    end

    class GlobalVariable < Identifier
    end

    class InstanceVariable < Identifier
    end

    class Variable < Identifier
    end
  end
end
