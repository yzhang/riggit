require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'uv'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the tm_syntax_highlighting plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the tm_syntax_highlighting plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TmSyntaxHighlighting'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end