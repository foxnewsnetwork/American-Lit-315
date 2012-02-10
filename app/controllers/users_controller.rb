class UsersController < ApplicationController
  before_filter :authorize_current_user, :except => [:index]

  def show
  	@user = User.find( params[:id] )
  end

  def new
  	@user = User.new
  end

  def index
  	@users = User.limit(150).paginate( :page => params[:page], :per_page => 10 )
  end

end
