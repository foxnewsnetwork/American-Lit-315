class CouponsController < ApplicationController
	def picture_path_builder(home_path, coupon)
		@path = home_path + 'system/pictures/'+ coupon.id.to_s+'/medium/'
	end	
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
		@home_path = 'http://0.0.0.0:3000/'
		
		if params[:random] == 'true'
		  # get a random coupon through count and offset
		  @coupon = Coupon.first(:offset => rand(Coupon.count))
		  @company = Company.find(@coupon.company_id)
		elsif params[:coupon_id] and is_a_number?(params[:coupon_id])
		  # this needs a proper resuce if we can't find the right coupon
		  @purpose = params[:xml]
		  @coupon = Coupon.find(params[:coupon_id]) 
		  @company = Company.find(@coupon.company_id)
		elsif params[:coupon_name]
		  # this needs a proper resuce if we can't find the right coupon
		  @purpose = params[:xml]
		  @coupon = Coupon.find_by_name(params[:coupon_name]) 
		  @company = Company.find(@coupon.company_id)
		end
		# build the picture path, this should probably be put somewhere else		
		@path = picture_path_builder(@home_path, @coupon)

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
			redirect_to :action => 'index', :params => {:company_id => @coupon.company_id}
		else 
			render 'new'
		end
		
    end

   def index
	puts "INDEX CALLED"
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @coupons = @company.coupons
    else
      @coupons = Coupon.all
    end
   end

	def destroy
		@coupon = Coupon.find(params[:id])
		@company_id = @coupon.company_id
  		@coupon.destroy
 
		respond_to do |format|
    			format.html { redirect_to "index" }
			#format.html { render :action => 'index', :params => {:company_id => @company_id} }
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


	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

end
