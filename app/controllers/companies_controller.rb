class CompaniesController < ApplicationController
  before_filter :authorize_current_company
  def show
  	@company = Company.find( params[:id] )
  	@correct_company = false
  	if company_signed_in?
  		@correct_company = @company.id == current_company.id
  	end
  	@coupons = @company.coupons.paginate( :page => params[:coupon_page], :per_page => 5)
  	@ads = @company.ads.paginate( :page => params[:ad_page], :per_page => 5)
  	@products = @company.products.paginate( :page => params[:product_page], :per_page => 5 )
  end

  def new
  	@company = Company.new
  end

  def index
  	@companies = Company.order("name DESC")
  end

end
