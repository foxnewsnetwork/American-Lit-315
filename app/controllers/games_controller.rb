class GamesController < ApplicationController

	def create_new_token
		(Digest::MD5.hexdigest "#{ActiveSupport::SecureRandom.hex(10)}-#{DateTime.now.to_s}")
	end

	def new_token
		@token = create_new_token
		g = Game.find(params[:game_id])
		g.token = @token
		g.save
		
		redirect_to :action => "index"
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

	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

end
