class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include UsersHelper

  def login
    @user = api_find_or_create_user(params[:user])
    unless @user.nil?
      sign_in @user
    end
  end

  def authorize_current_user
    #fill with authentication


  end
  def authorize_current_company
    #fill with authentication
  end

	# TODO:This breaks redirects for publisher and companies also
	# delete or find new solution
  #def after_sign_out_path_for(user)
	#	api_v1_product_inventory_display_path
  #end
  def after_sign_up_path_for(user)
		api_v1_product_user_shipping_address
  end
end
