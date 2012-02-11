# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Test use
c = Company.create( :name => "coke", :email => "coke@coke.coke", :password => "coke", :password_confirmation => "coke" )
u = User.create( :name => "lolcat", :email => "lolcat@lolcat.lolcat", :password => "lolcat", :password_confirmation => "lolcat" )
p = Publisher.create( :name => "blizzard", :email => "blizzard@blizzard.blizzard", :password => "blizzard", :password_confirmation => "blizzard" )


c.ads.create
c.ads.create
c.ads.create
c.coupons.create
c.coupons.create
c.coupons.create


