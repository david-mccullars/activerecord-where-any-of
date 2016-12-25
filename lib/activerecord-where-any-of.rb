require 'active_record'
if ActiveRecord::VERSION::MAJOR >= 5
  require 'active_record/where-any-of-mixin-rails-5'
else
  require 'active_record/where-any-of-mixin'
end
ActiveRecord::Base.send(:extend, ActiveRecord::WhereAnyOfMixin)
