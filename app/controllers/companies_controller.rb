class CompaniesController < ApplicationController
  before_filter :authorize_current_company
  def show
	@toolbar_hash = {:company => 'active'}
  	@company = current_company
	@coupons_count = @company.coupons.count
	@ads_count = @company.ads.count
	@products_count = @company.products.count
  	@correct_company = false
  	if company_signed_in?
  		@correct_company = @company.id == current_company.id
  	end
  	@coupons = @company.coupons.paginate( :page => params[:coupon_page], :per_page => 5)
  	@ads = @company.ads.paginate( :page => params[:ad_page], :per_page => 5)
  	@products = @company.products.paginate( :page => params[:product_page], :per_page => 5 )
  end

  def new
	@toolbar_hash = {:company => 'active'}
  	@company = Company.new
  end
  def create

      @company = Company.new(params[:company])

      if @company.save
        redirect_to companys_path
      else
        render 'companies/new'
      end

  end

  def index
	@toolbar_hash = {:company => 'active'}
	@toolbar_hash_company = 'active'
  	@companies = Company.order("name DESC")
  end

end
