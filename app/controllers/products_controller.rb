class ProductsController < ApplicationController

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
		
		if params[:random] == 'true'
		  # get a random product through count and offset
		  @product = Product.first(:offset => rand(Product.count))
		  @company = Company.find(@product.company_id)
    	elsif params[:company_id] and params[:id]
	      @product = Product.find(params[:id])
	      @company = Company.find(params[:company_id])
		elsif params[:product_id] and is_a_number?(params[:product_id])
		  # this needs a proper resuce if we can't find the right product
		  @purpose = params[:xml]
		  @product = Product.find(params[:product_id]) 
		  @company = Company.find(@product.company_id)
		elsif params[:product_name]
		  # this needs a proper resuce if we can't find the right product
		  @purpose = params[:xml]
		  @product = Product.find_by_name(params[:product_name]) 
		  @company = Company.find(@product.company_id)
		end
		# build the picture path, this should probably be put somewhere else		
		@small_path = picture_path_builder(root_url, @product, "small")
		@thumb_path = picture_path_builder(root_url, @product, "thumb")
		puts @small_path
		puts @thumb_path

		respond_to do |format|
			format.xml
			format.html
      		format.json
		end
	end


    def new
            @product = Product.new
    end

    def create
		@product = Product.new(params[:product])
		@product.company_id = current_company.id

		if @product.save
			flash[:success] = "Submit Success!"
			redirect_to :action => 'index', :params => {:company_id => @product.company_id}
		else 
			render 'new'
		end
		
    end

   def index
	puts "INDEX CALLED"
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @products = @company.products
    else
      @products = Product.all
    end
		respond_to do |format|
			format.html
			format.xml
		end
   end

	def destroy
		@product = Product.find(params[:id])
		@company_id = @product.company_id
	    @company = Company.find(@company_id)
  		@product.destroy

    	redirect_to company_products_path(@company)
	end

    # Pulls a random product record from the database 
	# TODO: add filtering
	def random_api
		@results =[]
		if params[:productid]
			if params[:productid].class == Array
				params[:productid].each do |e|
					@product = Product.find_by_id(e)
					if @product
						@results << @product
					end
				end
			else
				@product = Product.find(params[:productid])	
				@results << @product
			end
		else
			# get a random record number
			offset = rand(Product.count)
			# off set it
			rand_record = Product.first(:offset => offset)	
			# get the output in xml format
			@product = rand_record
			@results << @product
		end
		@no_token_error = {'message'=>'no token provided'}
		@invalid_token_error = {'message' => 'invalid token provided'}

		@user = User.new

		respond_to do |format|
			if params[:token].nil?
				# this is now turned off at Tom's request
				puts "NO TOKEN ERROR"
				#return format.json { render :json=> @no_token_error}
			end

			if Game.find_by_token(params[:token]).nil?
				puts "INVALID TOKEN ERROR"
				return format.json { render :json=> @invalid_token_error}
			end
			# all checks passed 	
			if params[:token] and params[:token] != '12345'
				@game = Game.find_by_token(params[:token])
				@game.increment!(:impressions) #increment impressions
				@game.earnings = @game.earnings + @product.price # pay the player by the cost of product
				@game.save
			end
			@results.each do |product|
				product.increment!(:displayed)
			end
			format.xml
			format.json
		end
	end

	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

	def update_product_api
		respond_to do |format|
			format.js do	
				@product = Product.find_by_id(params[:product_id])
				puts @product.name
				@product.increment!(:click_through)
				render :json=>"{'message':'OK'";
			end
		end
		
	end

	# upon click through
	# 1. Check if user is logged in, if not, ask for login if exists, else ask for email
	# 2. if logged in, extract email and send the product to user
	# 3. update user's click through of product, product's click through number
	def send_product
	 
	end

	# displays a page of inventory
	def inventory_display
		# give a record number, display that may products random products
		@products = []

		#offset = rand(Product.count)
		# off set it
		#rand_record = Product.first(:offset => offset)
		for type in Type.all do
			rand_record = Product.find_by_product_type(type.name)
		    if rand_record
				rand_record['picture_path'] = picture_path_builder(root_url, rand_record) + rand_record.picture_file_name
				@products << rand_record
		    end
	    end

		render :layout => false
	end

	def confirm_purchase
		# get user info (credit card and name)
			
		# dump into stats database
		# api call to Stripe
		if current_user.nil? and params[:user_id] == '-1'
			puts 'User ID doesnt exists, routing to make user register'
			redirect_to :controller=>'users',:action=>'product_user_prompt', :layout=>false, :product_id=>params[:product_id]
		# check if the user has a shipping address
		elsif current_user.shipping_addresses.count == 0
			# no shipping address!
			redirect_to :controller=>'shipping_addresses', :action=>'new', :layout=>false,:user_id => current_user.id, :product_id=>params[:product_id]
		# check if the user has a credit card
		elsif current_user.credit_card_token.nil?
			puts 'User credit card doesnt exists, routing to make user log credit card'
			@product_id = params[:product_id]	
			redirect_to :controller=>'users',:action=>'credit_card_new', :product_id=>@product_id,:layout=>false
		else 

			puts "Credit Card #{current_user.credit_card_token}"
			puts params[:user_id]
			puts 'Passed all test, lets confirm'
				

			@product = Product.find_by_id(params[:product_id])
			@product['picture_path'] = picture_path_builder(root_url, @product) + @product.picture_file_name
			@default_address = current_user.shipping_addresses.find_by_default(true)
			@user = current_user
			puts @user
			if current_user
				puts 'is logged in'
			end

			render :layout => false
		end
	end

	def confirm_purchase_create
		@i = Invoice.new(params[:invoice])
		if @i.save
			# TODO: send receipt email
			redirect_to :action=>'purchase_success', :layout=>false
		else
			render :layout=>false
		end
	end

	def api_purchase_create
		# user token doesn't exist
		# token is test case
		# token is invalid
		# token exists
		if params[:token].nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'a user token is required'}"}
			end
		end
		if params[:credit_card_token].nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'a credit card token is required'}"}
			end
		end
		if params[:product_id].nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'no product id'}"}
			end
		end
		@user = User.find_by_token(params[:token])
		@product = Product.find_by_id(params[:product_id])
		if @user.nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'your user token is invalid'}"}
			end
		end
		if @product.nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'product doesn't exist'}"}
			end
		end
		if @user.credit_card_token != params[:credit_card_token]
			respond_to do |format|
				format.json {render :json=>"{'error':'wrong credit card'}"}
			end
		end
		@s = @user.shipping_addresses.find_by_default(true)
		if @s.nil?
			respond_to do |format|
				format.json {render :json=>"{'error':'user doesn't have a shipping address'}"}
			end
		end
		@invoice = Invoice.new(
				:user_id =>@user.id,
				:product_id => @product.id,
				:shipping_address_id=> @s.id,
				:credit_card_token =>@user.credit_card_token,
				:price => @product.price
		)
		if @invoice.save
			# TODO: send receipt email
			respond_to do |format|
				format.json
			end
		else
			respond_to do |format|
				format.json {render :json=>"{'error':'failed to save invoice, please try again'}"}
			end
		end
	end

  # returns the most recent purchase
  def api_invoice_token
	# token doesn't exist
	# token is test case
	# token is invalid
	# token exists
	if params[:token].nil?
		respond_to do |format|
			format.json {render :json=>"{'error':'a user token is required'}"}
		end
	elsif params[:token] == '12345'
		@user = User.first
	elsif User.find_by_token(params[:token]).nil?
		respond_to do |format|
			format.json {render :json=>"{'error':'your user token is invalid'}"}
		end
	else	
		@user = User.find_by_token(params[:token])
		@invoice = Invoice.find_by_user(@user.id).last
		@product = @invoice.product_id

		if @invoice
			respond_to do |format|
				format.json
			end
		else
			respond_to do |format|
				format.json {render :json=>"{'error':'no invoice found'}"}
			end
		end
	end

  end
	def purchase_success
		render :layout=>false
	end

	def success_prompt
		render :layout => false
	end

	def picture_path_builder(root_url, product, type)
		@path = root_url + 'system/pictures/'+ product.id.to_s+'/'+type+'/'
	end	

end
