class HomepageController < ApplicationController

  def index
  	if !current_user.present?
      alert = flash[:alert]
      notice = flash[:notice]
  		reset_session
      flash.now[:alert] = alert
      flash.now[:notice] = notice
  	end

  	if session[:normal].present?
    	session[:name] = Normal.find_by(normalID: current_user.userID).first_name << " " << Normal.find_by(normalID: current_user.userID).last_name
  	elsif session[:promoter].present?
  		session[:name] = Promoter.find_by(promoterID: current_user.userID).name
  	else
  		session[:name] = "Ocorreu um erro"
  	end

    @categories = Category.all
    @promoters = Promoter.all
  end

end