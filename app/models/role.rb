class Role < ActiveRecord::Base
  #TODO: can try to see if API to get from config file 
  ALL_ROLES =[
  'Advisor',
  'Assistant',
  'Coadvisor'
  ]

  #checking how model can effect
  #if this is there, then db:seed will blow with
  #No matching rules found for create for
  ##<Authorization::GuestUser:0x1036e1f78 @role_symbols=[:guest]> (roles [:guest], privileges [:create, :manage], context :roles)
  #special mechanism has to be  built
  #
  using_access_control
  
  has_many :assignments
  has_many :users, :through => :assignments

  def self.seed
      ALL_ROLES.each {|role_name| self.find_or_create_by_name( :name => role_name)}
  end
end
