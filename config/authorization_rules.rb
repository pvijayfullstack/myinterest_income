authorization do
  #advisor has full power, restriction is less
  #say rsachdeva user having this role
  role :advisor do
    #manage is a named privilege
    has_permission_on [:customers], :to => :manage
    has_permission_on [:investments], :to => :manage
  end

  #coadvisor cannot delete investments
  #can create, view, edit customers and investments
  #say cosachdeva user having this role
  role :coadvisor do
    #includes :advisor
    has_permission_on [:customers], :to => :manage
    has_permission_on [:investments], :to => [:read, :create, :update]
  end

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

