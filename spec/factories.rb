Factory.define :user do |u|
  #u.email " Factory.next(:email) "
  u.email "test@email.com"
  u.password 'password'
  u.password_confirmation 'password'
  u.username 'first_user'
end