class Bank < ActiveRecord::Base
  has_many :investments

  validates_presence_of :name
  validates_uniqueness_of :name


  #to avoid any race conditions
  def self.create_or_find_by_name(name)
    ba = create!(:name => name)
  rescue ActiveRecord::RecordInvalid=> invalid
    ba = find_by_name(name)
    if(ba == nil)
       raise invalid
    end
    ba
#  rescue
#    ba = find_by_name(name)
#    logger.info(" 4attribute_for_inspect " + ba.attribute_for_inspect(:name));
  end
end
