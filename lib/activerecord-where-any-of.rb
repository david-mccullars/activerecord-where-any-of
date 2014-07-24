require 'active_record'
require 'active_record/where-any-of-mixin'
ActiveRecord::Base.send(:extend, ActiveRecord::WhereAnyOfMixin)
