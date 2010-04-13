class Bank < ActiveRecord::Base
  has_many :investments


  #to avoid any race conditions lets first try to create and then use find
  def self.create_or_find_by_name(name)
    ba = create!(:name => name)
  rescue ActiveRecord::RecordInvalid=> invalid
    ba = find_by_name(name)
    raise invalid  if(ba == nil)
    ba
  end
end
