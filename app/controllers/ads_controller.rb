class AdsController < ApplicationController
	# GET 
	def show
		@ad = Ad.find(params[:id])

		@company = @ad.company
		
		respond_to do |format|
			format.html
			format.xml
		end
	end


	def new
		@company = Company.find(params[:company_id])
		@ad = @company.ads.new
	end

	def create
		@company = Company.find( params[:company_id] )
		@ad = @company.ads.new( params[:ads] )
        if @ad.save
            flash[:success] = "Submit Success!"
            redirect_to [@company, @ad]
        else
            render 'new'
        end
	end
	
	# GET page for edit
	def edit
	
	end
	
	# PUT for update
	def update
	
	end
	
	# DELETE for killing
	def destroy
	
	end

end
