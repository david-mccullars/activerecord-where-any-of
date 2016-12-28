require "bundler/gem_tasks"
require "rspec/core/rake_task"

module WithoutBundler
  def run_task(*args)
    Bundler.with_clean_env do
      ENV['ACTIVE_RECORD_VERSION'] = $1 if name.to_s =~ /active_record_(\d+)/
      super
    end
  end
end

RSpec::Core::RakeTask.prepend(WithoutBundler)

namespace :spec do
  tasks = [3, 4, 5].map do |version|
    name = "active_record_#{version}"
    RSpec::Core::RakeTask.new(name).rspec_opts = '-O spec/spec.opts'
    name
  end

  desc "Run specs against all three versions of ActiveRecord"
  task all: tasks
end

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib/**/*.rb")
end
