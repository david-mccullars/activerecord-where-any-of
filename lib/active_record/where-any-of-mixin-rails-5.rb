# Rails 5+ mixin
module ActiveRecord
  module WhereAnyOfMixin

    def where_any_of(*conditions)
      # Rails 5 comes with an #or method for relations, so we can just use that
      # It is advised that once on Rails 5, this gem should be removed.
      conditions = conditions.map do |c|
        if c.is_a? Symbol or c.is_a? String
          self.unscoped.send(c)
        else
          c
        end
      end
      if conditions.empty?
        all.none
      else
        all.merge conditions.reduce(:or)
      end
    end

  end
end
