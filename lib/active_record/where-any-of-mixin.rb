module ActiveRecord
  module WhereAnyOfMixin

    def where_any_of(*conditions)
      # Takes any number of scopes and OR them together
      # into a new scope which can be combined with other scopes
      conditions = conditions.map do |c|
        if c.is_a? Symbol or c.is_a? String
          c = self.unscoped.send(c)
        end
        c.where_values.reduce(:and)
      end
      where(conditions.reduce(:or))
    end

  end
end
