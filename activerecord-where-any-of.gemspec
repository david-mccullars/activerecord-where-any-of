Gem::Specification.new do |s|
  s.name = 'activerecord-where-any-of'
  s.version = '1.1.2'
  s.license = 'MIT'
  s.date = '2020-05-12'
  s.summary = 'A simple mixin to ActiveRecord::Base that allows use of OR arel relations.'
  s.description = 'Should work in Rails 3, 4, & 5.  However, in Rails 5 use of #or is prefered.'
  s.description = File.read(File.expand_path('../README.md', __FILE__))[/Description:\n-+\s*(.*?)\n\n/m, 1]
  s.authors = ['David McCullars']
  s.email = ['david.mccullars@gmail.com']

  s.require_paths = ['lib']
  s.files         = `git ls-files -z`.split("\x0")

  s.add_runtime_dependency 'activerecord', '>= 3.0'
  s.add_development_dependency 'bundler', '>= 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'sqlite3'
end
