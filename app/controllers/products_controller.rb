class ProductsController < ApplicationController
	# GET 
	def show
		@product = Product.find(params[:products][:id])
		@company = @product.company
		
		respond_to do |format|
			format.xml
			format.html
		end
	end
	
end
