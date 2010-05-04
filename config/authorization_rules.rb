authorization do
  #president has full power for all customers created by group of advisors
  role :president do
    #manage is a named privilege
    has_permission_on [:customers], :to => :manage
    has_permission_on [:investments], :to => :manage
  end

  #advisor has full power on his own created customers and also its coadvisors, restriction is less
  #say rsachdeva user having this role
  role :advisor do
    #manage is a named privilege
    has_permission_on [:customers], :to => :manage do
      # user refers to the current_user when evaluating
      #note that user attribute user_id exists on context customer
      #the multiple if_attribute are ORed, otherwise :join has to be used
      #user.boss refers to the boss_id attribute
      #do something like this from console
      #sql happens as in SELECT "customers".* FROM "customers" WHERE (("customers"."user_id" = 4)
      #basically relationship set up using basic rails standard relationship so we can call methods here
      #for current user, if not there will show as null
      if_attribute :user_id => is {user.id}
      #if_attribute :user => is {user.advisor}
      if_attribute :user => is_in {user.managed_coadvisors}
    end
    has_permission_on [:investments], :to => :manage
  end

  #applies to only its own investments
  #coadvisor cannot delete investments
  #can create, view, edit customers and investments
  #say cosachdeva user having this role
  role :coadvisor do
    #includes :advisor
    has_permission_on [:customers], :to => :manage do
      # user refers to the current_user when evaluating
      #as in rails directly
      if_attribute :user => is {user}
    end
    has_permission_on [:investments], :to => [:read, :create, :update]
  end

  #applies to all investments from all advisors in read only mode however
  #assistant can do any read on customers and investments
  #say dsachdeva user having this role
  role :assistant do
    has_permission_on [:customers], :to => :read
    has_permission_on [:investments], :to => :read
  end

  #default guest can do only list of customers names read only, no investments at all
  #no login used
  role :guest do
    has_permission_on [:customers], :to => :list
  end
end


#privileges do
#  #the index, show etc are Privileges
#  #had to include :delete for model security. see comment in customer model
#  privilege :manage, :includes => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
#  privilege :inv_manage, :includes => [:create, :read, :update, :delete]
#  privilege :inv_manage_nodelete, :includes => [:create, :read, :update]
#  privilege :read, :includes => [:index, :show, :read]
#  privilege :only_list, :includes => [:index]
#end


privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :list, :includes => [:index]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end

