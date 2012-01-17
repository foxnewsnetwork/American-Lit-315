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
		@purpose = params[:xml]
		@coupon = Coupon.find(params[:id])
		@company = Company.find(@coupon.company_id)

		
		respond_to do |format|
			format.xml
			format.html
		end
	end


    def new
            @coupon = Coupon.new
    end

    def create
		@coupon = Coupon.new(params[:coupon])
		@coupon.company_id = current_company.id

		if @coupon.save
			flash[:success] = "Submit Success!"
			render 'index'
		else 
			render 'new'
		end
		
    end

   def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @coupons = @company.coupons
    else
      @coupons = Coupon.all
    end
   end

	def destroy
		@coupon = Coupon.find(params[:id])
  		@coupon.destroy
 
		respond_to do |format|
    			format.html { redirect_to '/business/coupons/manage' }
    			format.json { head :ok }
  		end
	end

	# thanks for the nice comments
	# rapid API requests
        # Pulls a random coupon record from the database 
	# and displays it without filtering or authentication
	# TODO: add filtering and authentication
	def random
		# get a random record number
		offset = rand(Coupon.count)
		# off set it
		rand_record = Coupon.first(:offset => offset)	
		# get the output in xml format
		@coupon = rand_record
		@home_path = 'http://0.0.0.0:3000/'
		@path = @home_path + 'system/pictures/'+@coupon.id.to_s+'/medium/'

		respond_to do |format|
		  #format.html {render :xml => @coupon}
		  format.xml 
		end
	end
	
end
