class Customer < ActiveRecord::Base
  # Activates model security for the current model.  Then, CRUD operations
  # are checked against the authorization of the current user.  The
  # privileges are :+create+, :+read+, :+update+ and :+delete+ in the
  # context of the model.  By default, :+read+ is not checked because of
  # performance impacts, especially with large result sets.
  using_access_control

  has_many :investments, :dependent => :destroy
  accepts_nested_attributes_for :investments, :allow_destroy => true
  validates_presence_of :name

end
