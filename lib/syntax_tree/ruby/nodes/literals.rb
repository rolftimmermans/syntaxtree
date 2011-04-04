require "syntax_tree/ruby/nodes/literal"

module SyntaxTree
  module Ruby
    class Nil < Literal
      def value
        nil
      end
    end

    class True < Literal
      def value
        true
      end
    end
  
    class False < Literal
      def value
        false
      end
    end

    class Integer < Literal
      def value
        token.to_i
      end
    end

    class Float < Literal
      def value
        token.to_f
      end
    end
    # 
    # class Char < Literal
    #   def value
    #     token[1]
    #   end
    # end
    # 
    # class Label < Literal
    #   def value
    #     token.gsub(":").to_sym
    #   end
    # end
  end
end
