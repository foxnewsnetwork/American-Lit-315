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

	if @user.shipping_addresses.create(params[:shipping_address])
		redirect_to :controller=>'users',:action=>'credit_card_new', :product_id=>@product_id,:layout=>false
	else
		redirect_to :action=>'new'
	end
  end

end
