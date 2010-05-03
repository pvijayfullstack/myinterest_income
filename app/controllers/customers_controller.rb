class CustomersController < ApplicationController
  #filter_resource_access
  #filter_access_to :all, :attribute_check => true
  #filter_access_to :index
  #filter_access_to :all


  #before_filter :require_user, :except => [:index] 
  before_filter :all_banks
  #rescue_from ActiveRecord::RecordInvalid, :with => :bank_name_not_found

  # Before filter to provide the objects for the actions where no params[:id]
  # is available. See TalksController for a case where this makes sense even
  # for the index action.
  #before_filter :load_conference, :only => [:show, :edit, :update, :destroy]
  #before_filter :new_conference, :only => [:new, :create]
  # Installs a before_filter to check accesses on all actions for the user's
  # authorization. :attribute_check causes the object in @conference to
  # be checked against the conditions in the authorization rules.
  #filter_access_to :all, :attribute_check => true
  #filter_access_to :index, :attribute_check => false

  before_filter :load_customer, :only => [:show, :edit, :update, :destroy]
  before_filter :new_customer, :only => [:new, :create]

  #filter_access_to implies it will check and not allow access if privilege not proper
  filter_access_to :edit, :require => :edit
  filter_access_to :index, :require => :index
  #this means that if filter_access_to :new is not specified, you are in unsecured zone and anyone can access it
   filter_access_to :new, :require => :new
   #same as above with respective action which implies default deny policy
   filter_access_to :all


  #filter_access_to :all means that any action will require same name permission/action for that privilege
  #filter_access_to :index, :require => :index, :attribute_check => false


  def index
     #@customers = Customer.all
     @customers = (has_role?(:guest)) ? Customer.all : Customer.with_permissions_to(:read).all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def new
    #@customer = Customer.new
    @customer.investments.build
  end
  
  def create
    #customer[investments_attributes][0][investment_name] in HTML
    #converts to "customer"=>{"name"=>"Jaimatadi", "investments_attributes"=>{"0"=>{"investment_amount"=>"25553.99", "investment_name"=>"Inv1", "investment_apy"=>"4.7"}}}}
    @customer.user = current_user
    #@customer = Customer.new(params[:customer])
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

#    @banks = Bank.all.collect {|b| [ b.name, b.name ] }
#    @banks << ["Add New Bank..", "-1"]
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated customer."
      redirect_to @customer
    else
      render :action => 'edit'
    end
  rescue ActiveRecord::RecordInvalid
    #@customer.errors.add_to_base("Bank name is blank")
    render :action => 'new'
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


  # provided by the default filter_resource_access before_filters
  def load_customer
    @customer = Customer.find(params[:id])
  end

  def new_customer
    puts "params[:customer] is #{params[:customer]}"
    @customer = Customer.new(params[:customer])
  end
end
