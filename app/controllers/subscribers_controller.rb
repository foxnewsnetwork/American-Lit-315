class SubscribersController < ApplicationController
	def create
		@subscriber = Subscriber.create(params[:subscriber])
		@success = false

		if @subscriber.save
			@success = true
			@msg = 'Thank you for signing up! You will be the first to know when we launch.'
			
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
