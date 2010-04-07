class Bank < ActiveRecord::Base
  has_many :investments
end
