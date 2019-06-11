# Rails 4+ mixin
module ActiveRecord
  module WhereAnyOfMixin

    def where_any_of(*conditions)
      # Takes any number of scopes and OR them together
      # into a new scope which can be combined with other scopes
      bind_values = []
      conditions = conditions.map do |c|
        if c.is_a? Symbol or c.is_a? String
          c = self.unscoped.send(c)
        end
        bind_values.concat(c.bind_values)
        __convert_string_wheres(c.where_values).reduce(:and)
      end
      if conditions.empty?
        respond_to?(:none) ? none : where('1=0')
      else
        s = where(conditions.reduce(:or))
        s.bind_values += bind_values if bind_values.present?
        s
      end
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
