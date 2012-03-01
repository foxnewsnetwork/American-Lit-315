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
	
  def after_sign_out_path_for(resources)
		if current_user
			return api_v1_product_inventory_display_path
		end
		if current_company
			return root_path
		end

		if current_publisher
			return root_path
		end
		# this should actually be a 404 path or something
		root_path
  end
	
	#def after_sign_in_path_for(resources)
	#	if current_user
	#		puts "params #{params}"
	#		return api_v1_product_confirm_purchase_path
	#	end
	#	root_path
	#end	
	
  private

end
