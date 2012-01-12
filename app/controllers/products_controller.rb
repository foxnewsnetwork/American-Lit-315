class ProductsController < ApplicationController
	# GET 
	def show
		@purpose = params[:xml]
		@product = Product.find(params[:products][:id])
		unless @coupon
			flash[:error] = "ERROR CODE 0001: no such coupon exists"
		end
		@company = @product.company
	end
end
