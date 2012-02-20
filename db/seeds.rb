# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Test use

###############################################
# This creates and populates the type model with
# some based types of products
###############################################
Type.delete_all
Type.create(:name => "food")
Type.create(:name => "electronic")
Type.create(:name => "toy")
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
###################################################

###################################################
# This generates 3 test accounts for sample/testing
###################################################
c = Company.new( :name => "coke", :email => "coke@coke.coke", :password => "coke12", :password_confirmation => "coke12" )
a = User.new( :name => "lolcat", :email => "lolcat@lolcat.lolcat", :password => "lolcat", :password_confirmation => "lolcat" )
p = Publisher.new( :name => "blizzard", :email => "blizzard@blizzard.blizzard", :password => "blizzard", :password_confirmation => "blizzard" )

# list of objects you want to seed
object_list = [c, a, p]

# seed and inform
object_list.each { |obj| inform(obj)}
###################################################


###################################################
# this simulates first game 's redemptions
# between start of first game's create and today, 
# create between 1 - 10 redemptions per day
# NOTE: Set :attr_accessible for :created_at in 
# app/model/game_earnings.rb or the created at simulation
# WOULDN'T work
###################################################
g = Game.first
start_date = g.created_at
end_date = DateTime.now

while start_date < end_date
	start_date = start_date + 1.days
	r = rand(10)
	puts "#{r} coupons/rewards on start_date"
	while r > 0
		@ge = GameEarnings.new(
			:game_id => 1, 
			:coupon_id => 1, 
			:earnings => 0.75, 
			:coupon_cost => 0.75,
			:user_id => 1,
			:created_at => start_date
		)
		@ge.save
		r -= 1
	end
end
##################################################

#c.ads.create
#c.ads.create
#c.ads.create
#c.coupons.create
#c.coupons.create
#c.coupons.create



