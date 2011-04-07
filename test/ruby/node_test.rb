require File.expand_path("../test_helper", File.dirname(__FILE__))

class NodeTest < Test::Unit::TestCase
  def setup
    @klass = Class.new Ruby::Node
    @node = @klass.new
  end

  test "node should define node accessors" do
    @klass.class_eval do
      define_nodes :foo, :bar
    end
    @node.foo, @node.bar = "foo", "bar"
    assert { [@node.foo, @node.bar] == ["foo", "bar"] }
  end

  test "append node should define node accessor" do
    @klass.class_eval do
      define_nodes :foo, :bar
      append_nodes :baz
    end
    @node.baz = "baz"
    assert { @node.baz == "baz" }
  end

  test "append node should define node accessor" do
    @klass.class_eval do
      define_nodes :foo, :bar
      prepend_nodes :qux
    end
    @node.qux = "qux"
    assert { @node.qux == "qux" }
  end

  test "nodes should return child nodes" do
    @klass.class_eval do
      define_nodes :foo, :bar
    end
    @node.foo, @node.bar = "foo", "bar"
    assert { @node.nodes == ["foo", "bar"] }
  end

  test "nodes should return child nodes with appended nodes last" do
    @klass.class_eval do
      define_nodes :foo, :bar
      append_nodes :baz
    end
    @node.foo, @node.bar, @node.baz = "foo", "bar", "baz"
    assert { @node.nodes == ["foo", "bar", "baz"] }
  end

  test "nodes should return child nodes with prepended nodes first" do
    @klass.class_eval do
      define_nodes :foo, :bar
      prepend_nodes :qux
    end
    @node.qux, @node.foo, @node.bar = "qux", "foo", "bar"
    assert { @node.nodes == ["qux", "foo", "bar"] }
  end

  test "nodes should return child nodes without nil nodes" do
    @klass.class_eval do
      define_nodes :foo, :bar, :baz
    end
    @node.foo, @node.bar, @node.baz = "foo", nil, "baz"
    assert { @node.nodes == ["foo", "baz"] }
  end

  test "node names should return list of node names" do
    @klass.class_eval do
      define_nodes :foo, :bar
      append_nodes :baz
    end
    assert { @klass.node_names == [:foo, :bar, :baz] }
  end

  test "node names should return list of node names including ancestor node names" do
    @klass.class_eval do
      define_nodes :foo, :bar
    end
    subklass = Class.new(@klass) do
      append_nodes :baz
    end
    assert { subklass.node_names == [:foo, :bar, :baz] }
  end
end
