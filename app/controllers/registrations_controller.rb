# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController


  def create
  if(params[:company])
    @company = Company.new(params[:company])
      puts("HI");
    if @company.save
      sign_in @company
      respond_to do |format|
      format.js { render(:update) { |page| page.redirect_to @company } }
      end
      else
       respond_to do |format|
      format.js
      end
      end

  else
      @publisher = Publisher.new(params[:publisher])

    if @publisher.save
      sign_in @publisher
      respond_to do |format|
      format.js { render(:update) { |page| page.redirect_to @publisher } }
      end
      else
       respond_to do |format|
      format.html { redirect_to root_path }
      format.js
      end
      end
    end
  end


end