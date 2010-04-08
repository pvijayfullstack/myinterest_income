class CustomersController < ApplicationController

  before_filter :all_banks

  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def new
    @customer = Customer.new
    @customer.investments.build
  end
  
  def create
    #customer[investments_attributes][0][investment_name] in HTML
    #converts to "customer"=>{"name"=>"Jaimatadi", "investments_attributes"=>{"0"=>{"investment_amount"=>"25553.99", "investment_name"=>"Inv1", "investment_apy"=>"4.7"}}}}
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = "Successfully created customer."
      redirect_to @customer
    else
      render :action => 'new'
    end
  rescue
    @customer.errors.add("Bank name")
    render :action => 'new'
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @customer.investments.build unless @customer.investments.exists?
    #uses for selected in name terms
    #http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html
#    Another common case is a select  tag for an belongs_to-associated object.
#
#    Example with @post.person_id => 2:
#
#      select("post", "person_id", Person.all.collect {|p| [ p.name, p.id ] }, {:include_blank => 'None'})
#
#    could become:
#
#      <select name="post[person_id]">
#        <option value="">None</option>
#        <option value="1">David</option>
#        <option value="2" selected="selected">Sam</option>
#        <option value="3">Tobias</option>
#      </select>

    @banks = Bank.all.collect {|b| [ b.name, b.name ] }
    @banks << ["Add New Bank..", "-1"]
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated customer."
      redirect_to @customer
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = "Successfully destroyed customer."
    redirect_to customers_url
  end


  def all_banks
    @banks = Bank.all.collect {|b| [ b.name, b.name ] }
    @banks << ["Add New Bank..", "-1"] 
  end
end
