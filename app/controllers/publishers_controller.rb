class PublishersController < ApplicationController
  def show
	@toolbar_hash = {:publisher => 'active'}
	@games = current_publisher.games
	if current_publisher.token.nil?
		@token = create_new_token
	else
		@token = current_publisher.token
	end
  end
	def new_token
		@token = create_new_token
		redirect_to :action => "show"
	end

	def create_new_token
		string = (Digest::MD5.hexdigest "#{ActiveSupport::SecureRandom.hex(10)}-#{DateTime.now.to_s}")
		current_publisher.token = string
		current_publisher.save!
		return string
	end

  def new
	@toolbar_hash = {:publisher => 'active'}
  end

  def index
	@toolbar_hash = {:publisher => 'active'}
  end

end
