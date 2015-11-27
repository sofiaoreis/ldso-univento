class HomepageController < ApplicationController
  def index
  	if session[:normal].present?
    	session[:name] = Normal.find_by(normalID: current_user.userID).first_name << " " << Normal.find_by(normalID: current_user.userID).last_name
  	elsif session[:promoter].present?
  		session[:name] = Promoter.find_by(promoterID: current_user.userID).name
  	else
  		session[:name] = "Ocorreu um erro"
  	end
  end
end
