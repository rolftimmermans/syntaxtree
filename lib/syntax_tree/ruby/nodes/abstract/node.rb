module SyntaxTree
  module Ruby
    class Node
      class << self
        def define_nodes(*nodes)
          attr_accessor *nodes
          singleton_class.send(:define_method, :node_names) { nodes }
        end

        def append_nodes(*nodes)
          define_nodes *(node_names + nodes)
        end

        def prepend_nodes(*nodes)
          define_nodes *(nodes + node_names)
        end
      end

      def initialize(assignments = {})
        assignments.each { |node, value| send :"#{node}=", value }
      end

      def nodes
        self.class.node_names.collect { |name| send name }.flatten.compact
      end
    end
  end
end
