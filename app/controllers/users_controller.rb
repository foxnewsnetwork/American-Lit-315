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
