require 'bundler'
require 'rake'
require 'rake/testtask'
require 'spec'
require 'spec/rake/spectask'

Bundler::GemHelper.install_tasks

desc 'Default: run specs'
task :default => :"spec:all"

def alias_task(name, old_name)
  t = Rake::Task[old_name]
  desc t.full_comment if t.full_comment
  task name, *t.arg_names do |_, args|
    # values_at is broken on Rake::TaskArguments
    args = t.arg_names.map { |a| args[a] }
    t.invoke(args)
  end
end

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

alias_task("spec", "spec:all")

