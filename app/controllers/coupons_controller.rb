class CouponsController < ApplicationController
	# GET 
	def show
		@purpose = params[:xml]
		@coupon = Coupon.find(params[:coupons][:id])
		unless @coupon
			flash[:error] = "ERROR CODE 0001: no such coupon exists"
		end
		@company = @coupon.company
	end
	
end
