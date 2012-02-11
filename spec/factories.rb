Factory.define :coupon do |u|
  u.name "coupon"
end
Factory.define :company do |u|
  u.email "company@gmail.com"
  u.name "companyName"
  u.password "password"
end
Factory.define :user do |u|
  #u.email " Factory.next(:email) "
  u.email "test@email.com"
  u.password 'password'
  u.password_confirmation 'password'
  u.username 'first_user'
end
