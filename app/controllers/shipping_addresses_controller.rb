class ShippingAddressesController < ApplicationController
  def new
	@product_id = params[:product_id]
	render :layout => false
  end

  def show
  end
  def edit

  end

  def create
	@user = User.find_by_id(params[:user_id])
	@product_id = params[:product_id]
	@user.shipping_addresses.new(params[:shipping_address])
	params[:shipping_addresses][:user_id] = params[:user_id]
	s = ShippingAddress.new(params[:shipping_addresses])

	if s.save
		# this is teh user's new default address
		p = @user.shipping_addresses.find_by_default(true)
		if p
			p.default = false
			p.save
		end
		s.default = true
		s.save

		redirect_to :controller=>'products',:action=>'confirm_purchase', :product_id=>@product_id,:layout=>false
	else
		redirect_to :action=>'new', :product_id=>@product_id
	end
  end

end
