class Customer < ActiveRecord::Base
  has_many :investments, :dependent => :destroy
  accepts_nested_attributes_for :investments, :allow_destroy => true
  validates_presence_of :name
end
