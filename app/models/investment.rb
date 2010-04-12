class Investment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank
  #callbacks explitic here to help with Bank using belongs_to
#  before_create :bank_create_or_update
#  before_update :bank_create_or_update
  #before_validation :bank_create_or_update

  #note here we use the virtual attribute from belongs_to in validation
  validates_presence_of :investment_name, :investment_amount, :investment_apy, :investment_years
  validates_numericality_of :investment_amount
  validates_numericality_of :investment_apy, :less_than => 20
  validates_numericality_of :investment_years, :less_than => 100

  def validate
     bank_create_or_update
  end
  

  def compound_interest_years
    apy = investment_apy/100
    calculated_result_partial = (1+apy)**investment_years
    (investment_amount*calculated_result_partial)-investment_amount
  end


  def average_interest_monthly
    interest_per_day = (compound_interest_years)/(investment_years*365)
    interest_per_day*30
  end

  #virtual attribute used
  #just for nested attributes; helpful for creating in new, updating in edit
  #<%= inv_f.text_field :bank %><br />
  def bank=(name)
    @invest_bank_name=name
  end

  #just for nested attributes; helpful for reading in edit
  def bank
    if !((self.read_attribute(:bank_id)).nil?)
      b = Bank.find(self.read_attribute(:bank_id))
      b.name
    end
  end


  #part of validation
  def bank_create_or_update
     #b = Bank.find(:name => @invest_bank_name)
     b = Bank.create_or_find_by_name(@invest_bank_name)
     #b.save!
     #using investment belongs to bank
     #setting investment attribute before create or update for investment happens
     if (b != nil)
       self.write_attribute(:bank_id, b.id)
     end
  rescue ActiveRecord::RecordInvalid => e
     self.errors.add(:bank, "name is blank")
     #eventually for save to be false in customer controller to show this error
     return false
  end

#  def bank_update
#     b = @invest_bank_name
#     b = Bank.find(self.read_attribute(:bank_id))
#     b.name = @invest_bank_name
#     b.save!
#     #using investment belongs to bank
#     self.write_attribute(:bank_id, b.id)
#  end

end
