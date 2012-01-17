class CompaniesController < ApplicationController
  def show
  	@company = Company.find( params[:id] )
  	@correct_company = false
  	if company_signed_in?
  		@correct_company = @company.id == current_company.id
  	end
  	@coupons = @company.coupons.paginate( :page => params[:page], :per_page => 1)
  	@ads = @company.ads.paginate( :page => params[:page], :per_page => 1)
  	@products = @company.products.paginate( :page => params[:page], :per_page => 10 )
  end

  def new
  	@company = Company.new
  end

  def index
  	@companies = Company.order("name DESC")
  end

end
