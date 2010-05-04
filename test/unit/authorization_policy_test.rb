require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  def test_president_can_create
    president = Factory.build(:president)
    #assert users_of_role(president).can :create, :customers
    users_of_role(president) do
      should_be_allowed_to :create, :customers
    end
  end

  def test_user_president_can_create
    user = Factory.build(:user)
    user.roles << Factory.build(:president)
    with_user user do
      should_be_allowed_to :create, :customers
    end
  end

  #TODO: as needed more investigation can be done
#  def test_user_coadvisor_can_create
#    user = Factory.build(:user)
#    user.roles << Factory.build(:coadvisor)
#    #create customer
#    c = Customer.new
#    with_user user do
#      should_be_allowed_to :read, c
#    end
#  end


    protected
    def users_of_role (*roles)
      @roles_for_checks = roles
      self
    end

    def only_users_of_role (*roles)
      @roles_for_checks = Authorization::Engine.instance.roles - roles
      result_flip!
      self
    end
  end