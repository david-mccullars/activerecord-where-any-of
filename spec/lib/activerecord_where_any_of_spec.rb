require 'spec_helper'
require 'activerecord-where-any-of'

describe 'where_any_of' do

  subject { ExampleModel }

  let(:lparen) do
    '(' if ActiveRecord::VERSION::MAJOR <= 3
  end

  let(:rparen) do
    ')' if ActiveRecord::VERSION::MAJOR <= 3
  end

  describe '(*relations)' do

    let(:relation) do
      subject.where_any_of(
        subject.active.on_shelf('h'),
        subject.inactive.recent,
        subject.with_name('apple'),
      )
    end

    specify :count do
      expect(relation.count).to eq(6)
    end

    specify :first do
      m = relation.first
      expect(m.id).to eq(1)
      expect(m.name).to eq('apple')
    end

    specify :to_sql do
      expect(relation.to_sql).to match_ignoring_whitespace(<<-END)
        SELECT "example_models".*
        FROM "example_models"
        WHERE #{lparen}((
             "example_models"."active" = 't' AND (name LIKE 'h%')
          OR "example_models"."active" = 'f' AND (created_at > '2016-11-01'))
          OR "example_models"."name" = 'apple'
        )#{rparen}
      END
    end

    specify :group_count do
      expect(relation.group(:active).count).to match(true => 2, false => 4)
    end

    specify :order_limit do
      expect(relation.order('updated_at DESC').limit(2).pluck(:name)).to eq [
        "historiette boxthorn quinaldine",
        "slipcase diorthotic holocentrid plessimetry prestudiously",
      ]
    end

  end

  describe "(:symbol, 'string', relation)" do

    let(:relation) do
      subject.where('name <> ?', 'bad').where_any_of(
        :recent,
        'active',
        subject.on_shelf('z'),
      )
    end

    specify :count do
      expect(relation.count).to eq(38)
    end

    specify :merge_and_count do
      expect(relation.merge(subject.inactive).count).to eq(4)
    end

    specify :to_sql do
      expect(relation.to_sql).to match_ignoring_whitespace(<<-END)
        SELECT "example_models".*
        FROM "example_models"
        WHERE (name <> 'bad') AND #{lparen}((
             (created_at > '2016-11-01')
          OR "example_models"."active" = 't')
          OR (name LIKE 'z%')
        )#{rparen}
      END
    end

  end

end
