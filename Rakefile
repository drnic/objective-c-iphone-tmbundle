require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "TMBundle Test Task"
task :default => [ :test ]
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'Support/test/*_test.rb'
  t.verbose = true
  t.warning = false
}
Dir['tasks/**/*.rake'].each { |file| load file }
