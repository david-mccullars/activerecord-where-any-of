class ExampleModel < ActiveRecord::Base

  def self.with_name(name)
    where(name: name)
  end

  def self.on_shelf(letter)
    letter =~ /\A[a-z]\z/i ? where("name LIKE '#{letter}%'") : where('1=0')
  end

  def self.active
    where(active: true)
  end

  def self.inactive
    where(active: false)
  end

  def self.recent
    where('created_at > ?', Date.parse('2016-11-01'))
  end

end
