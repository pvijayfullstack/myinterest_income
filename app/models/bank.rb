class Bank < ActiveRecord::Base
  has_many :investments

  validates_uniqueness_of :name

  #to avoid any race conditions
  def self.create_or_find_by_name(name)
      create!(:name => name) rescue find_by_name(name)
  end

end
