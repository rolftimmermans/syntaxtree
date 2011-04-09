require "rake/testtask"

task :default => :test

Rake::TestTask.new do |test|
  test.pattern = "test/**/*_test.rb"
end

task :dot do
  $: << File.expand_path("lib", File.dirname(__FILE__))
  require "syntax_tree"
  require "syntax_tree/visitors/to_dot"
  SyntaxTree::Visitors::ToDot.new.accept(SyntaxTree::RubyParser.read(ARGV[1])).output(pdf: "Ruby.pdf")
end
