require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyModuleTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert module definition with semicolons" do
      src = "module Foo;; end"
      assert { to_ruby(src) == src }
    end

    should "convert module definition with newlines" do
      src = "module Foo\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert module definition with namespaced constant" do
      src = "module Foo::Bar::Baz\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert module definition with absolutely namespaced constant" do
      src = "module ::Foo::Bar::Baz\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert module definition with statements" do
      src = "module Foo::Bar::Baz\n\nfoo\nbar\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert module definition with method definitions" do
      src = <<-RUBY
        module Foo::Bar::Baz
          def foo
            puts "foo"
          end

          def bar(a, b = nil)
            puts "bar"
          end
        end
      RUBY
      assert { to_ruby(src) == src }
    end
  end
end
