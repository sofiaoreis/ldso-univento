class HomepageController < ApplicationController

  def index
  	if !current_user.present?
      alert = flash[:alert]
      notice = flash[:notice]
  		reset_session
      flash.now[:alert] = alert
      flash.now[:notice] = notice
  	end

    @categories = Category.all
    @promoters = Promoter.all
  end

end