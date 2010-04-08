class Bank < ActiveRecord::Base
  has_many :investments

  validates_presence_of :name, :on => :create
  validates_uniqueness_of :name, :on => :create

  def validate_on_create
    if name.blank?
      errors.add("Bank name cannot be blank.")
    end
  end


  #to avoid any race conditions
  def self.create_or_find_by_name(name)  
    create!(:name => name) rescue find_by_name(name)
  end

  def check_bank_valid
    valid?
  end

end
