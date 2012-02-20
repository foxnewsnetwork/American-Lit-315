class GamesController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]

	def create_new_token
		(Digest::MD5.hexdigest "#{ActiveSupport::SecureRandom.hex(10)}-#{DateTime.now.to_s}")
	end

	def new_token
		@token = create_new_token
		g = Game.find(params[:game_id])
		g.token = @token
		g.save
		
		redirect_to :action => "show", :id =>g.id
	end

    def new
            @game = Game.new
    end

    def create
		@game = Game.new(params[:game])
		@game.publisher_id = current_publisher.id
		@game.token = create_new_token

		if @game.save
			flash[:success] = "Submit Success!"
			redirect_to :action => 'index', :params => {:publisher_id => @game.publisher_id}
		else 
			render 'new'
		end
		
    end

   def index
    if params[:publisher_id]
      @publisher = Publisher.find(params[:publisher_id])
      @games = @publisher.games
    else
      @games = Game.all
    end
     respond_to do |format|
			format.html
			format.xml
		end
   end

	def destroy
		@game = Game.find(params[:id])
		@publisher_id = @game.publisher_id
  		@game.destroy
 
		respond_to do |format|
    			#format.html { redirect_to "index" }
			format.html { redirect_to :action => 'index', :params => {:publisher_id => @publisher_id} }
    			format.json { head :ok }
  		end
	end

	def update
	    @game = Game.find(params[:id])
	    if @game.update_attributes(params[:game])
    		  flash[:success] = "Profile updated."
		      redirect_to :action => 'index'
	    else
	      @title = "Edit Game"
	      render :action => 'update'
    end	

	end

	def show
		@game = Game.find(params[:id])
		@chart = GoogleChart.pie(10,20,40,30)
		@chart = GoogleChart.pie(['1997',10],['1998',20],['1999',40],['2000',30])
		@daily_earnings = GameEarnings.select("sum(earnings) as daily_earning, created_at").group("date(created_at)")
		@labels = [{:id=>'date', :label=>'Date', :type=>'date'},
					{:id=>'pencils', :label=>'Sold Pencils', :type=>'number'}]

   		respond_to do |format|
			format.html
			format.json
		end
		

	end

	def edit
		@game = Game.find(params[:id])
		@title = "Edit Game"
	end

	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

  private

    def authenticate
      deny_access unless signed_in?
    end

end
