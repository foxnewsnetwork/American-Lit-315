class AdsController < ApplicationController
	# GET 
	def show
		@purpose = params[:xml]
		@ad = Ad.find(params[:ads][:id])
		unless @coupon
			flash[:error] = "ERROR CODE 0001: no such coupon exists"
		end
		@company = @ad.company
	end
end
