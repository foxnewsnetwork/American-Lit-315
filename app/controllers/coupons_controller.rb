class CouponsController < ApplicationController

	# use this or add protect_from_forger :except=> :create
	skip_before_filter :verify_authenticity_token, :except => [:create, :destroy, :update]

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
    	elsif params[:company_id] and params[:id]
	      @coupon = Coupon.find(params[:id])
	      @company = Company.find(params[:company_id])
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
      format.json
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
     respond_to do |format|
			format.html
			format.xml
		end
   end

	def destroy
		@coupon = Coupon.find(params[:id])
		@company_id = @coupon.company_id
    @company = Company.find(@company_id)
  		@coupon.destroy
 

    	 redirect_to company_coupons_path(@company)

	end

	# thanks for the nice comments
	# rapid API requests
    # Pulls a random coupon record from the database 
	# TODO: add filtering
	def random_api
		# get a random record number
		offset = rand(Coupon.count)
		# off set it
		rand_record = Coupon.first(:offset => offset)	
		# get the output in xml format
		@coupon = rand_record
		@home_path = 'http://0.0.0.0:3000/'
		@path = @home_path + 'system/pictures/'+@coupon.id.to_s+'/medium/'

		@no_token_error = {'message'=>'no token provided'}
		@invalid_token_error = {'message' => 'invalid token provided'}

		@user = User.new

		respond_to do |format|
			if params[:token].nil?
				puts "NO TOKEN ERROR"
				format.json { render :json=> @no_token_error}
			elsif Game.find_by_token(params[:token]).nil?
				puts "INVALID TOKEN ERROR"
				format.json { render :json=> @invalid_token_error}
			else
				@game = Game.find_by_token(params[:token])
				@game.increment!(:impressions) #increment impressions
				@coupon.increment!(:displayed)
				#@game.earnings = @game.earnings + @coupon.cost_per_redeem # pay the player by the cost of coupon
				#@gameEarnings = GameEarnings.new(:game_id=>@game.id, :coupon_id=>@coupon.id, :earnings=>@game.earnings, :coupon_cost => @coupon.cost_per_redeem, :user_id=>1)
				#@gameEarnings.save
				#@game.save

				#format.html {render :xml => @coupon}
				format.xml
				format.json
			end
		end
	end

	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

	def update_coupon_api
		respond_to do |format|
			format.js do	
				@coupon = Coupon.find_by_id(params[:coupon_id])
				puts @coupon.name
				@coupon.increment!(:click_through)
				render :json=>"{'message':'OK'";
			end
		end
		
	end

	# upon click through
	# 1. Check if user is logged in, if not, ask for login if exists, else ask for email
	# 2. if logged in, extract email and send the coupon to user
	# 3. update user's click through of coupon, coupon's click through number
	def send_coupon
	 
	end

	def picture_path_builder(home_path, coupon)
		@path = home_path + 'system/pictures/'+ coupon.id.to_s+'/medium/'
	end	

end
