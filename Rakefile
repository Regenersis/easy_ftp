require 'rake'
require 'rake/testtask'
require 'spec'
require 'spec/rake/spectask'

desc 'Default: run specs'
task :default => :spec


desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
