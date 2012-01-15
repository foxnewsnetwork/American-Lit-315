class AdsController < ApplicationController
	# GET 
	def show
		@purpose = params[:xml]
		@ad = Ad.find(params[:ads][:id])
		unless @coupon
			flash[:error] = "ERROR CODE 0001: no such coupon exists"
		end
		@company = @ad.company
	end


	def new
		@company = Company.find(params[:company_id])
		@ad = @company.ads.new
	end

	def create
		@ad = Ad.new(params[:ad])

                if @ad.save
                        flash[:success] = "Submit Success!"
                        redirect_to '/business/ads/manage'
                else
                        render 'new'
                end
                

	
	end

	def manage
		@ad = Ad.all
	end
end
