class ProductsController < ApplicationController
	Stripe.api_key = "9sir8teed4nvvwDoSOjBgy29k4pNy3iF"

	# use this or add protect_from_forger :except=> :create
	skip_before_filter :verify_authenticity_token, :except => [:create, :destroy, :update]

	def edit
		@product = Product.find(params[:id])
		# detect if the user has no product and bump him to the correct
		# page
		if @product.nil?
			@new = true
		end
	end
	# PUT request, xml for the api
	def update
		# 2 modes of operation
		@product = Product.find(params[:id])

		if @product.update_attributes(params[:product])
			flash[:success]="Update Success!"
			redirect_to edit_company_product_path
		else
			flash[:error]="Failed to updated!"
			redirect_to edit_company_product_path
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
		@product.picture = nil
		@product.save

		@company_id = @product.company_id
	    @company = Company.find(@company_id)
  		@product.destroy

    	redirect_to company_products_path(@company)
	end

    # Pulls a random product record from the database 
	# TODO: add filtering
	def random_api

		@user = User.new

		respond_to do |format|
			if params[:token].nil?
				puts "NO TOKEN ERROR"
				@message='no token provided'
				@success = false
				return format.json
			elsif Game.find_by_token(params[:token]).nil?
				puts "INVALID TOKEN ERROR"
				@message ='invalid token provided'
				@success = false
				return format.json
			else
				@results =[]
				@message = 'success'
				@success = true

				if params[:url]
					puts "there is an url present #{params[:url]}"
		
					@results = parse_url(params[:url])
					puts @results
				elsif params[:productid]
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

				parse_ip(params[:ip])

				# all checks passed 	
				@game = Game.find_by_token(params[:token])
				@game.increment!(:impressions) #increment impressions
				
				@results.each do |product|
					#@game.earnings = @game.earnings + product.price # pay the player by the cost of product
					#@game.save
					product.increment!(:displayed)
				end
				format.xml
				format.json
			end
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
		# always returns 4 products
		@results_max = 4
		@results = []

		if params[:url]
			puts "there is an url present #{params[:url]}"

			@results = parse_url(params[:url])
			if @results.count > 4
				@results = @results[1..@results_max]
			end
			puts @results
		elsif params[:productid]
			if params[:productid].class == Array
				for i in @results_max
					params[:productid].each do |e|
						@product = Product.find_by_id(e)
						if @product
							@results << @product
							if @results.count > 4
								@results = @results[1..@results_max]
							end
						end
					end
				end
			else
				for i in @results_max
					@product = Product.find(params[:productid])	
					@results << @product
					if @results.count > 4
						@results = @results[1..@results_max]
					end
				end
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

	###########################################################3
	# API Section
	###########################################################3
	def api_purchase_create
		# user token doesn't exist
		# token is test case
		# token is invalid
		# token exists
		# if playtoken doesn't exi
		@message = ''
		@success = false
		if params[:gametoken].nil?
				@message =  'a game token is required.'
				return respond_to :json
		end

		if params[:productid].nil?
				@message = 'a product id is required.'
				return respond_to :json
		end
	
		if Product.find_by_id(params[:productid]).nil?
				puts 'no product'
				puts 'no product'
				puts 'no product'
				puts 'no product'
				puts 'no product'
				puts 'no product'
				puts 'no product'
				puts 'no product'
				@message = 'no such product exits.'
				return respond_to :json
		end

		if params[:usertoken].nil?
				@message = 'a user token is required. user is not logged in?'
				return respond_to :json
		end
		
		if User.find_by_token(params[:usertoken]).nil?
				@message = 'no such user exists.'
				return respond_to :json
		end
		#check_nil_and_respond(params[:gametoken], 'a game token is required.')
		#check_nil_and_respond(params[:productid], 'a product id is required.')
		#@product = Product.find_by_id(params[:productid])
		#check_nil_and_respond(@product, 'no such product exits.')
		#check_nil_and_respond(params[:usertoken], 'a user token is required. user is not logged in?')
		#@user = User.find_by_token(params[:usertoken])
		#check_nil_and_respond(@user, 'no such user exists.')
	
		# at this point, we have User, the product the user want to buy,
		# and where the user is buying the stuff from
		# let's buy it

		# user buy it via the Stripe API
		# we will need to have
		# a Stripe customer id to buy the product
		# if not, then we need the user's credit card to credit a customer id
		# so we can charge him or her without them submitting the credit card
		# info again
		@product = Product.find_by_id(params[:productid])
		@user = User.find_by_token(params[:usertoken])
		if @user.stripe_id.nil?
			if params[:card].nil?
				@message = "no credit card on file"
				return respond_to :json	
			end
			#check_nil_and_respond(params[:card], "no credit card on file.")
			# passed the check, recreate credit card	
			create_credit_card_for_user(params[:card], @user)
		end

		# check if the item needs a shipping address
		# if not, go directly to charging and invoice
		if params[:shipping_address_required] == 'true'
			@s = @user.shipping_addresses.find_by_default(true)
			if @s.nil?
				@message = "no shipping address"
				return respond_to :json	
			end
			#check_nil_and_respond(@s, "no shipping address.")
			@shipping_address_id = @s.id
		end

		@invoice = Invoice.new(
				:user_id =>@user.id,
				:product_id => @product.id,
				:shipping_address_id=> @shipping_address_id,
				:stripe_id =>@user.stripe_id,
				:price => @product.price
		)

		if @invoice.save
			# TODO: send receipt email
			charge_customer(@user, @product)
			@message = "purchase success"
			@success = true
			return respond_to :json
			#respond_to do |format|
			#	format.json
			#	return
			#end
		else
			@message = "failed to create invoice, please try again"
			return respond_to :json
			#respond_to do |format|
			#	format.json
			#	return
			#end
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
	
	private
		# limit the query to only products with specific tags
		def parse_url(para)
			@url = params[:url]
			@tag = url_to_tag(@url)
			puts "Tag #{@tag} founder"

			# pull the id of the type where keyword = tag
			@keywords = Keyword.where(:name=>@tag)
			puts @keywords

			@types = []
			@keywords.each do |x|
				t = Type.where(:id=>x.type_id)
				t.each do |x|
					puts x.name
				end
				@types += t
			end
			puts "line 383 #{@types}"

			@products = []
			@types.each do |t|
				p = Product.where(:product_type=>t.name)
				@products += p
			end

			return @products
		end
		
		# fill this out later when you figure out how to solve product collisions
		def parse_ip(para)
			if para.nil?
			end
		end

		def url_to_tag(url)
			url = "http://#{url}" if URI.parse(url).scheme.nil?
			host = URI.parse(url).host.downcase
			host.start_with?('www.') ? host[4..-5] : host[0..-5]
		end

		def create_credit_card_for_user(cardhash, user)
			# create a customer with the given credit card number

			token = Stripe::Token.create( 
				:card => { 
					:number => cardhash[:number], 
					:exp_month => cardhash[:expmon], 
					:exp_year => cardhash[:expyear], 
					:cvc => cardhash[:cvc]
					}, 
						:currency => "usd" 
			)

			# create a Customer
			customer = Stripe::Customer.create(
				:card => token.id,
				:description => "Create new customer that we can charge."
			)

			# save the customer id
			@user.stripe_id = customer.id
			@user.save

		end
	
		def charge_customer(user, product)
			# charge the Customer instead of the card
			# convert price to integer
			price = @product.price * 100
			price = price.to_i

			Stripe::Charge.create(
					:amount => price, # in cents
					:currency => "usd",
					:customer => user.stripe_id
			)
		end

		def check_nil_and_respond(obj, message)
			if obj.nil?
				@message = message
				respond_to :json
				return
			end
		end
end
