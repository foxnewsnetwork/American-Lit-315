class ProductsController < ApplicationController
	# GET 
	def show
		@product = Product.find(params[:products][:id])
		@company = @product.company
		
		respond_to do |format|
			format.xml
			format.html
      format.json {respond_with @product}
		end
  end

  def index
      if params[:company_id]
      @company = Company.find(params[:company_id])
      @products = @company.products
    else
      @products = Product.all
    end
    respond_to do |format|
			format.html
			format.xml
			format.json { respond_with @products }
		end
  end
	
end
