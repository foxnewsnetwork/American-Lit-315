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



        def new
                @coupon = Coupon.new
        end

        def create
		@coupon = Coupon.new(params[:coupon])

		if @coupon.save
			flash[:success] = "Submit Success!"
			redirect_to '/business/coupons/manage'
		else 
			render 'new'
		end
		

        end

        def manage
                @coupons = Coupon.all
        end

	
end
