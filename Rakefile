require 'rake'
require 'rake/testtask'
require 'spec'
require 'spec/rake/spectask'

desc 'Default: run specs'
task :default => :"spec:all"

namespace :spec do
  desc "Run all specs in spec directory"
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

  desc "Run all specs in units directory"
  Spec::Rake::SpecTask.new(:unit) do |t|
    t.spec_files = FileList['spec/units/**/*_spec.rb']
  end

  desc "Run all specs in integration directory"
  Spec::Rake::SpecTask.new(:integration) do |t|
    t.spec_files = FileList['spec/integration/**/*_spec.rb']
  end
end


