class PublishersController < ApplicationController
  def show
	@toolbar_hash = {:publisher => 'active'}
  end

  def new
	@toolbar_hash = {:publisher => 'active'}
  end

  def index
	@toolbar_hash = {:publisher => 'active'}
  end

end
