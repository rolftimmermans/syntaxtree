module SyntaxTree
  module Ruby
    class Node
      class << self
        def define_nodes(*nodes)
          attr_accessor *nodes
          class << self; self; end.send(:define_method, :node_names) { nodes }
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

      # def inspect
      #   inspected_nodes = self.class.node_names.collect do |name|
      #     node = send(name)
      #     if node.kind_of? ::Array
      #       lines = node.map(&:inspect).join("\n").split("\n")
      #     else
      #       lines = node.inspect.split("\n")
      #       lines.first << " (#{name})"
      #     end
      #     lines.join("\n  ")
      #   end.join("\n")
      #
      #   "#<#{self.class.name.sub("Ruby::", "")}\n  " + inspected_nodes + "\n"
      # end
    end
  end
end
