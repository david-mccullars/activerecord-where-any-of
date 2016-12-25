if ENV['COVERAGE'] =~ /^t/i
  require 'simplecov'

  SimpleCov.start 'root_filter' do
    add_filter '/spec/'
  end
end

require 'rspec'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
