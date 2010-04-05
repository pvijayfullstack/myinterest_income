class Investment < ActiveRecord::Base
  belongs_to :customer

  def average_monthly
    investment_amount*investment_years
  end
end
