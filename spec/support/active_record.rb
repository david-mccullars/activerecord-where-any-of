version = ENV.fetch('ACTIVE_RECORD_VERSION', '3.0').to_f
raise "Unsupported ActiveRecord version #{version.inspect}" unless version >= 3.0 && version < 6.0
gem 'activerecord', "~> #{version}"

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: File.expand_path('../../database.sqlite3', __FILE__),
)
