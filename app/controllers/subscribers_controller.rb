class SubscribersController < ApplicationController
	def create
		@subscriber = Subscriber.create(params[:subscriber])
		@success = false

		if @subscriber.save
			@success = true
			@msg = 'Success!'
			
			flash['msg'] = @msg
			respond_to do |format|
				format.js
				format.html {redirect_to root_path}
			end
		else
			@msg = 'Failed!'
			flash['msg'] = @msg
			respond_to do |format|
				format.js
				format.html {redirect_to root_path}
			end
		end
	end
end
