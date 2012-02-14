class UsersController < ApplicationController
  before_filter :authorize_current_user, :except => [:index]

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
end
