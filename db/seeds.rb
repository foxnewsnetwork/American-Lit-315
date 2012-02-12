# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Test use
def inform(obj)
	if obj.save
		puts "Type: " + obj.to_s
		puts "Name: " + obj.name
		puts "Password: " + obj.password
		puts "Successfully created!"
		puts
	else
		puts "Something's went wrong!"
		puts obj.errors
		puts
	end
end


c = Company.new( :name => "coke", :email => "coke@coke.coke", :password => "coke12", :password_confirmation => "coke12" )
a = User.new( :name => "lolcat", :email => "lolcat@lolcat.lolcat", :password => "lolcat", :password_confirmation => "lolcat" )
p = Publisher.new( :name => "blizzard", :email => "blizzard@blizzard.blizzard", :password => "blizzard", :password_confirmation => "blizzard" )

# list of objects you want to seed
object_list = [c, a, p]

# seed and inform
object_list.each { |obj| inform(obj)}

#c.ads.create
#c.ads.create
#c.ads.create
#c.coupons.create
#c.coupons.create
#c.coupons.create



