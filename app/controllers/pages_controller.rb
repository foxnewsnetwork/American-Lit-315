class PagesController < ApplicationController
  def home
		@subscriber = Subscriber.new
		@company = Company.new
  end

  def front
		@company = Company.new
  end

  def index
  end

  def misc
  end

  def about
  end

  def contact
  end

  def documentation
  end
end
