require 'bundler'
require 'rake'
require 'rake/testtask'
require 'spec'
require 'spec/rake/spectask'

Bundler::GemHelper.install_tasks

desc 'Default: run specs'
task :default => :"spec:all"

namespace :spec do
  desc "Run all specs in spec directory"
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

  desc "Run all specs in units directory"
  Spec::Rake::SpecTask.new(:lib) do |t|
    t.spec_files = FileList['spec/lib/**/*_spec.rb']
  end

  desc "Run all specs in integration directory"
  Spec::Rake::SpecTask.new(:integration) do |t|
    t.spec_files = FileList['spec/integration/**/*_spec.rb']
  end
end
