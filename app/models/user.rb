class User < ActiveRecord::Base
  acts_as_authentic
  has_many :assignments
  has_many :roles, :through => :assignments

  #TODO: this is just for demo purposes for authorization_rules to show up
  #Basically standard rails relationships can be set up in production
  belongs_to :advisor, :class_name => "User", :foreign_key => :advisor_id
  has_one :advisor, :class_name => "User", :foreign_key => :advisor_id

  def role_symbols
    roles.map do |r|
      puts "role.name.underscore.to_sym is #{r.name.underscore.to_sym}"
      r.name.underscore.to_sym
    end
  end
end
