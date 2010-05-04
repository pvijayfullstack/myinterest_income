

Factory.define :president, :class => Role do |r|
  r.name "President"
end

Factory.define :advisor, :class => Role do |r|
  r.name "Advisor"
end

Factory.define :coadvisor, :class => Role do |r|
  r.name "Coadvisor"
end

Factory.define :assignment, :class => Assignment do |b|
  b.role {|a| a.association(:user)}
  b.user {|a| a.association(:role)}
end

Factory.define :user, :class => User do |u|
  u.username   'user'
  u.email    'user@example.com'
  u.password 'dancing'
  u.password_confirmation { |p| p.password }  
  #u.association :roles, :factory => [:advisor]
  #u.roles {|roles| [roles.association(:advisor)]}
end

Factory.define :role, :class => Role do |r|
end




