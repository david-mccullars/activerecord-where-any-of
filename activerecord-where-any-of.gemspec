Gem::Specification.new do |s|
  s.name = "activerecord-where-any-of"
  s.version = "1.0.0"
  s.date = "2014-07-24"
  s.summary = "A simple mixin to ActiveRecord::Base that allows OR'ing arel relations."
  s.description = '...'
  s.description = File.read(File.expand_path('../README.md', __FILE__))[/Description:\n-+\s*(.*?)\n\n/m, 1]
  s.authors = ["David McCullars"]
  s.email = ["david.mccullars@gmail.com"]

  s.add_runtime_dependency 'activerecord', '~> 3.0'

  s.files = Dir['lib/**/*.rb']

  s.require_paths = ['lib']
end
