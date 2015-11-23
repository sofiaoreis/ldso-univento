class HomepageController < ApplicationController
  def index
  	if session[:normal].present?
    	@name = Normal.find_by(normalID: current_user.userID).first_name << " " << Normal.find_by(normalID: current_user.userID).last_name
  	elsif session[:promoter].present?
  		@name = Promoter.find_by(promoterID: current_user.userID).name
  	else
  		@user = User.new
  	end
  end
end
