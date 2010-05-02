class Investment < ActiveRecord::Base
  using_access_control
  
  belongs_to :customer
  belongs_to :bank


  #note here we use the virtual attribute from belongs_to in validation
  validates_presence_of :investment_name, :investment_amount, :investment_apy, :investment_years
  validates_numericality_of :investment_amount
  validates_numericality_of :investment_apy, :less_than => 20
  validates_numericality_of :investment_years, :less_than => 100

  #investment manages the bank model creation here through its virtual attribute bank
  #Customer can select a bank from dop down or Instantly Select New Bank using jQuery to create a New Bank
  #This could be done in callbacks. Added here for validation errors to showup also
  #the customer controller will display the errors as they are added to investments, returning false
  #This keeps customer controller code clean unaware of the extra model custom validation error being done
  def validate
     #custom validation and creation for bank model
     bank_validate_create_or_update
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


  def bank_validate_create_or_update
     #b = Bank.find(:name => @invest_bank_name)
     b = Bank.create_or_find_by_name(@invest_bank_name)
     self.write_attribute(:bank_id, b.id) if (b != nil)
     #b.save!
     #using investment belongs to bank
     #setting investment attribute before create or update for investment happens
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
