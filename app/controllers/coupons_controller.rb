class CouponsController < ApplicationController
	# PUT request, xml for the api
	def update
		# 2 modes of operation
		respond_to do |format|
			format.html do
				# TODO: write me!
			end
			
			format.xml do
				# TODO: write me!
			end
		end
		
	end

	# GET 
	def show
		@coupon = Coupon.find(params[:coupons][:id])
		@company = @coupon.company
		
		respond_to do |format|
			format.xml
			format.html
		end
	end

	# WTF IS THIS SHIT?!
	def api
		offset = rand(Coupon.count)
		rand_record = Coupon.first(:offset => offset)	
		@output = rand_record.to_xml
		render :layout => false	
	end

    def new
            @coupon = Coupon.new
    end

    def create
		@coupon = Coupon.new(params[:coupon])

		if @coupon.save
			flash[:success] = "Submit Success!"
			render 'index'
		else 
			render 'new'
		end

    end

    def index
            @coupons = Coupon.all
    end

	def destroy
		@coupon = Coupon.find(params[:id])
  		@coupon.destroy
 
		respond_to do |format|
    			format.html { redirect_to '/business/coupons/manage' }
    			format.json { head :ok }
  		end
	end

	
end
