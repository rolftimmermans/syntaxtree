require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyClassTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert class definition with semicolons" do
      src = "class Foo;; end"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with newlines" do
      src = "class Foo\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with superclass" do
      src = "class Foo < Bar\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with namespaced constant" do
      src = "class Foo::Bar::Baz\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with absolutely namespaced constant with whitespaces" do
      src = "class ::Foo::Bar::Baz\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with namespaced constant and superclass" do
      src = "class Foo::Bar::Baz  < Foo::Bar::Qux\n\nfoo\nbar\n\nend"
      assert { to_ruby(src) == src }
    end

    should "convert class definition with method definitions" do
      src = <<-RUBY
        class Foo::Bar::Baz
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

    should "convert class definition with singleton class methods" do
      src = <<-RUBY
        class Foo::Bar::Baz
          class << self
            def foo
              puts "foo"
            end

            def bar(a, b = nil)
              puts "bar"
            end
          end

          def foo
            puts "foo"
          end
        end
      RUBY
      assert { to_ruby(src) == src }
    end
  end
end
