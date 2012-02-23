class UsersController < ApplicationController

  before_filter :authorize_current_user, :except => [:index]

  def create_new_token
		(Digest::MD5.hexdigest "#{ActiveSupport::SecureRandom.hex(10)}-#{DateTime.now.to_s}")
  end

  def show
	@toolbar_hash = {:user => 'active' }
  	@user = User.find( params[:id] )
  end

  def new
	@toolbar_hash = {:user => 'active' }
  	@user = User.new
  end

  def index
	@toolbar_hash = {:user => 'active' }
	puts @toolbar_hash
	puts @toolbar_hash[:user]
	puts "is this right?"
  	@users = User.limit(150).paginate( :page => params[:page], :per_page => 10 )
  end

  def user_email_only_form
	@user = User.new
	render :layout => false
  end

  def user_email_only_create
	@user = User.new(params[:user])
	if @user.save
		# send email
		redirect_to :action=> "user_email_only_success"
	else 
		redirect_to :action=> "user_email_only_failure"
	end
  end

  def user_email_only_success
	render :layout => false
  end

  def user_email_only_failure
	render :layout => false
  end

  def product_user_sign_in
	render :layout => false
  end
  def product_user_register
	render :layout => false
  end

  def credit_card_new
        @product_id = params[:product_id]

	render :layout => false
  end
  def credit_card_edit
	render :layout => false
  end
  def credit_card_create
	Stripe.api_key = "9sir8teed4nvvwDoSOjBgy29k4pNy3iF"
	@user = current_user
	# get credit card info
	# send to stripe and/or store it through post call
	response = Stripe::Token.create(:card=>params[:card],:currency=>"usd")
	
	# catch token and store that
	token = response.zip[7][0][1]
	puts token
	# store the token in the user db
	@user.credit_card_token = token
	@product_id = params[:product_id]
	puts @user.credit_card_token
	if @user.save
		puts 'we saved the token'
		redirect_to :controller=>'products', :action=>'confirm_purchase', :layout => false,:user_id=>params[:user_id],:product_id=>params[:product_id]
	else
		puts 'we did not save the token'
		redirect_to :action=>'new',:layout=>false, :product_id=>params[:product_id],:user_id=>params[:user_id]
	end
  end

  def api_credit_card_create	
	Stripe.api_key = "9sir8teed4nvvwDoSOjBgy29k4pNy3iF"
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
			format.json {render :json=>"{'error'=>'your user token is invalid'}"}
		end
	else	
		@user = User.find_by_token(params[:token])
		# TODO: another check to see if the card number and cvc are all correct
		response = Stripe::Token.create(:card=>params[:card],:currency=>"usd")
		# catch token and store that
		token = response.zip[7][0][1]
		# store the token in the user db
		@user.credit_card_token = token
		if @user.save
			respond_to do |format|
				format.json {rener :json=>"{'card_token'=>token}"}
			end
		else
			respond_to do |format|
				format.json {render :json=>"''error':'something went wrong and your card didnt save'}"}
			end
		end
	end
  end

  def api_credit_card_token
	Stripe.api_key = "9sir8teed4nvvwDoSOjBgy29k4pNy3iF"
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
		token = @user.credit_card_token
		if token
			respond_to do |format|
				format.json {render :json=>"{'card_token':token}"}
			end
		else
			respond_to do |format|
				format.json {render :json=>"{'error':'user doesnt have a credit card token'}"}
			end
		end
	end

  end

  def api_login
    #convert what params we want to an info hash
    info = Hash["email" => params[:email], "password" => params[:password],"username" => params[:username] ,"gametoken" => params[:gametoken]]

    #check if the user is legit
    @user = user_check(info)

    #if no user we'll give token of nothing!'
    @user_token = ""

    #the user did not give a correct password, so, successful login is false.
    if @user.nil?
      @successful_login = "false"
    else
      #user is legit so give him a token as well as set successful login as true
      @user_token = create_new_token
      @user.token = @user_token
      @successful_login = "true"
    end

    #give as a json...
    respond_to do |format|
      format.json
    end
  end

  private

  #check if the user is legit. 3 cases
  #1. If the email exists but the password is wrong. Return nil
  #2. if the password is correct, return the user
  #3. if the user does not exist be nice and create it for him.
  def user_check(info)
          unless User.find_by_email(info["email"]).nil?
            @user = User.find_by_email(info["email"])
            unless @user.valid_password?(info["password"])
              return nil
            end
            return @user
          else
            @user = User.create(:email => info["email"],:coupon_id => info["coupon"], :game_id => info["game"] )
            return @user
          end
  end
end
