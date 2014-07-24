activerecord-where-any-of
=========================

Description:
-----------

Provides a mechanism for OR'ing together one or more AREL relations.  Normally when
one performs `SomeModel.where(condition_1).where(condition_2)`, the result is to AND
those conditions together.  Unfortunately, there is no good way of OR'ing them without
converting the conditions into manual SQL.  This mixin addresses that issue.

Usage:
------

`where_any_of` accepts any number of relations, symbols, or strings.  For symbols and strings,
the corresponding method is called (unscoped) which is expected to return a relation.

```rb
class SomeRecord < ActiveRecord::Base

  default_scope do
    where('extra is not null')
  end

  def self.owned_by(user)
    where(:owner => user)
  end

  def self.active
    where(:active => true)
  end

  def self.pending
    where(:pending => true)
  end

  def self.active_or_pending
    # Use symbols to make sure calls are unscoped
    where_any_of(:active, :pending)
  end

end
```

```rb
puts SomeRecord.owned_by('Fred').active_or_pending.to_sql
```

> SELECT "some_records".* FROM "some_records"
> WHERE "some_records"."owner" = 'Fred' AND (extra is not null) AND (("some_records"."active" = 't' OR "some_records"."pending" = 't'))

```rb
puts SomeRecord.where_any_of(
  SomeRecord.where(:extra => 'A'),
  SomeRecord.owned_by('Bill'),
  'active'
).to_sql
```

> SELECT "some_records".* FROM "some_records"
> WHERE (extra is not null) AND ((("some_records"."extra" = 'A' OR "some_records"."owner" = 'Bill') OR "some_records"."active" = 't'))

Install:
--------

In your app, add this line to your `Gemfile`:

```rb
gem "activerecord-where-any-of"
```

Then type `bundle`.
