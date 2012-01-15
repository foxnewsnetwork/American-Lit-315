class PicsController < ApplicationController
  def new
	@pic = Pic.create(params[:pic])
  end

  def edit
  end

  def index
  end

  def show
	@pics = Pic.all
  end
end
