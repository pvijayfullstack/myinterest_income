class User < ActiveRecord::Base
  acts_as_authentic
  has_many :assignments
  has_many :roles, :through => :assignments

  def role_symbols
    roles.map do |r|
      puts "role.name.underscore.to_sym is #{r.name.underscore.to_sym}"
      r.name.underscore.to_sym
    end
  end
end
