class CustomersController < ApplicationController
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
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @customer.investments.build unless @customer.investments.exists?
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
end
