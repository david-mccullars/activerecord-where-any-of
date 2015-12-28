module ActiveRecord
  module WhereAnyOfMixin

    def where_any_of(*conditions)
      # Takes any number of scopes and OR them together
      # into a new scope which can be combined with other scopes
      conditions = conditions.map do |c|
        if c.is_a? Symbol or c.is_a? String
          c = self.unscoped.send(c)
        end
        __convert_string_wheres(c.where_values).reduce(:and)
      end
      where(conditions.reduce(:or))
    end

    def __convert_string_wheres(wheres)
      wheres.map do |w|
        if w.is_a?(Arel::Nodes::Equality)
          w
        else
          w = Arel.sql(w) if String === w
          Arel::Nodes::Grouping.new(w)
        end
      end
    end

  end
end
