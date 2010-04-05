class Investment < ActiveRecord::Base
  belongs_to :customer

  def compound_interest_years
    apy = investment_apy/100
    calculated_result_partial = (1+apy)**investment_years
    (investment_amount*calculated_result_partial)-investment_amount
  end


  def average_interest_monthly
     interest_per_day = (compound_interest_years)/(investment_years*365)
     interest_per_day*30
  end
  
end
