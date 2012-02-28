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
  def after_sign_out_path_for(users)
		api_v1_product_inventory_display_path
  end

  def after_sign_up_path_for(users)
		api_v1_product_user_shipping_address
  end
<<<<<<< HEAD
	
  #def after_sign_out_path_for(publisher)
	#	root_path
  #end
  #def after_sign_out_path_for(company)
	#	root_path
  #end
=======
  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
>>>>>>> 45ff6ee5595767971b9dad6bee321b99eebc53d8
end
