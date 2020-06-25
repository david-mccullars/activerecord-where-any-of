# Rails 5+ mixin
module ActiveRecord
  module WhereAnyOfMixin

    INVALID_RELATION_VALUES = %i[
      eager_load
      group
      union_ordering
      union
      unscope
      window
      with
    ]

    RELATION_VALUES_TO_COPY = %i[
      includes
      joined_includes
      joins
      left_outer_joins
      preload
      references
    ]

    def where_any_of(*conditions)
      # Rails 5 comes with an #or method for relations, so we can just use that
      # It is advised that once on Rails 5, this gem should be removed.

      # Do our best to preserve joins from the conditions into the outer relation
      values_to_copy = {}

      conditions = conditions.map do |c|
        c = self.unscoped.send(c) if c.is_a? Symbol or c.is_a? String
        raise ArgumentError, "Unsupported argument type: #{c.class.name}" unless c.is_a?(ActiveRecord::Relation)

        INVALID_RELATION_VALUES.each do |m|
          raise ArgumentError, "Unsupported condition contains #{m} values" if c.send("#{m}_values").present?
        end

        RELATION_VALUES_TO_COPY.each do |m|
          values = c.send("#{m}_values").presence or next
          values_to_copy[m] ||= []
          values_to_copy[m].concat(values)
        end

        # Only preserve the where clause of the condition
        c2 = ActiveRecord::Relation.new(c.klass)
        c2.where_clause = c.where_clause
        c2
      end

      if conditions.empty?
        all.none
      else
        all_with_copied_values = values_to_copy.reduce(all) do |s, (key, values)|
          s.send(key, values)
        end
        all_with_copied_values.merge conditions.reduce(:or)
      end
    end

  end
end
