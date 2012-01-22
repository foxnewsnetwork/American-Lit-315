class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # I run into 'module cannot be convered into string error'
  # if this is not commented out
  include UsersHelper

  def login
    @user = api_find_or_create_user(params[:user])
    unless @user.nil?
      sign_in @user
    end
  end
end
