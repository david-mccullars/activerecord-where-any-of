require "bundler/gem_tasks"

namespace :rspec do

  desc "Run specs against ActiveRecord 3"
  task :active_record_3 do
    sh 'ACTIVE_RECORD_VERSION=3 rspec -O spec/spec.opts'
  end

  desc "Run specs against ActiveRecord 4"
  task :active_record_4 do
    sh 'ACTIVE_RECORD_VERSION=4 rspec -O spec/spec.opts'
  end

  desc "Run specs against ActiveRecord 5"
  task :active_record_5 do
    sh 'ACTIVE_RECORD_VERSION=5 rspec -O spec/spec.opts'
  end

  desc "Run specs against all three versions of ActiveRecord"
  task all: [:active_record_3, :active_record_4, :active_record_5]

end
