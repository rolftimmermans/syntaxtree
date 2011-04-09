module SyntaxTree
  module Visitors
    class Base
      def accept(object)
        visit object
      end

      protected

      DISPATCH = Hash.new do |hash, klass|
        # SyntaxTree::Ruby::MetaClass -> "visit_ruby_meta_class"
        name = klass.name || ""
        name.gsub!(/SyntaxTree::/, "")
        name.gsub!("::", "_")
        name.gsub!(/([a-z])([A-Z])/,'\1_\2')
        name.downcase!
        hash[klass] = "visit_#{name}"
      end

      def visit(object)
        send DISPATCH[object.class], object
      rescue NoMethodError => error
        raise error if respond_to?(DISPATCH[object.class], true)
        superklass = object.class.ancestors.find { |klass| klass.kind_of? Class and respond_to?(DISPATCH[klass], true) }
        raise TypeError, "Cannot visit #{object.class}" unless superklass
        DISPATCH[object.class] = DISPATCH[superklass]
        retry
      end
    end
  end
end
