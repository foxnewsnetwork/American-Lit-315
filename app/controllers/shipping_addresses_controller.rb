class ShippingAddressesController < ApplicationController
  def new
	@shipping_address = ShippingAddresses.new
	@product_id = params[:product_id]
	render :layout => false
  end

  def show
  end
  def edit

  end

  def create
	@ship_address = ShippingAddresses.new(params[:shipping_address])
	redirect_to :action=>'payments#new', :layout=>false
  end

end
