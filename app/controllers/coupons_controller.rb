class CouponsController < ApplicationController
	# GET 
	def show
		@purpose = params[:xml]
		@coupon = Coupon.find(params[:id])
    @company = Company.find(params[:company_id])

		unless @coupon
			flash[:error] = "ERROR CODE 0001: no such coupon exists"
		end
	end

	def api
		offset = rand(Coupon.count)
		rand_record = Coupon.first(:offset => offset)	
		@output = rand_record.to_xml
		render :layout => false	
	end

        def new
                @coupon = Coupon.new
        end

        def create
		@coupon = Coupon.new(params[:coupon])
    @coupon.company_id = current_company.id
		if @coupon.save
			flash[:success] = "Submit Success!"
			render 'index'
		else 
			render 'new'
		end
		

        end

        def index
          if params[:company_id]
            @company = Company.find(params[:company_id])
            @coupons = @company.coupons
          else
            @coupons = Coupon.all
          end
        end

	def destroy
		@coupon = Coupon.find(params[:id])
  		@coupon.destroy
 
		respond_to do |format|
    			format.html { redirect_to '/business/coupons/manage' }
    			format.json { head :ok }
  		end
	end

	
end
