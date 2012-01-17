class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # I run into 'module cannot be convered into string error'
  # if this is not commented out
  #require UsersHelper
end
