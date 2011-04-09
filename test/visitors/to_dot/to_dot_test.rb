require File.expand_path("../../test_helper", File.dirname(__FILE__))

class BaseVisitorTest < Test::Unit::TestCase
  context "base" do
    subject { Visitors::ToDot.new }

    should "should accept program" do
      src = <<-RUBY
        class Foo
          def bar(baz, qux = nil, *args, &block)
            puts "bar"
          end
        end
      RUBY
      klass = subject.accept(parse(src)).class
      assert { klass == GraphViz }
    end
  end
end
