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
		@home_path = 'http://0.0.0.0:3000/'
		
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
		@path = picture_path_builder(@home_path, @product)

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
		# get a random record number
		offset = rand(Product.count)
		# off set it
		rand_record = Product.first(:offset => offset)	
		# get the output in xml format
		@product = rand_record
		@home_path = 'http://0.0.0.0:3000/'
		@path = @home_path + 'system/pictures/'+@product.id.to_s+'/medium/'

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
				@game.earnings = @game.earnings + @product.price # pay the player by the cost of product
				@game.save

				@product.increment!(:displayed)
				#format.html {render :xml => @product}
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
		# get 3 random ones
		# get a random record number
		@home_path = 'http://0.0.0.0:3000/'
		@products = []

		#offset = rand(Product.count)
		# off set it
		#rand_record = Product.first(:offset => offset)
    for type in Type.all do

    rand_record = Product.find_by_product_type(type.name)
    if rand_record
		rand_record['picture_path'] = picture_path_builder(@home_path, rand_record) + rand_record.picture_file_name
		@products << rand_record
    end
    end
		#rand_record = Product.find_by_product_type('food')
		#rand_record['picture_path'] = picture_path_builder(@home_path, rand_record) + rand_record.picture_file_name
		#@products << rand_record
    #
		#rand_record = Product.find_by_product_type('electronic')
		#rand_record['picture_path'] = picture_path_builder(@home_path, rand_record) + rand_record.picture_file_name
		#@products << rand_record
    #
		#rand_record = Product.find_by_product_type('toy')
		#rand_record['picture_path'] = picture_path_builder(@home_path, rand_record) + rand_record.picture_file_name
		#@products << rand_record

		render :layout => false
	end

	def picture_path_builder(home_path, product)
		@path = home_path + 'system/pictures/'+ product.id.to_s+'/medium/'
	end	

end
