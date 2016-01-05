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
      if !session[:name].present?
    	 session[:name] = Normal.find_by(normalID: current_user.userID).first_name << " " << Normal.find_by(normalID: current_user.userID).last_name
  	  end
    elsif session[:promoter].present?
      if !session[:name].present?
  		  session[:name] = Promoter.find_by(promoterID: current_user.userID).name
      end
  	else
  		session[:name] = "Ocorreu um erro"
  	end

    @categories = Category.all
    @promoters = Promoter.all
    if session[:back].present?
      if session[:back] != root_url
        redirect_to session[:back]
      end
    end
  end

end