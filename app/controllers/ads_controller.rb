class AdsController < ApplicationController
	# GET 
	def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @ads = @company.ads
      @ads = Ad.all
    else
      @ads = Ad.all
    end
  end
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
		@ad = @company.ads.create( params[:ad] )
        if @ad.save!
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
