class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
	    @user,normal,register = User.from_omniauth(request.env["omniauth.auth"])
	    
	    if @user.persisted? #entra sempre aqui 
	      if register
	      	sign_in @user, :event => :authentication
	      	set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	      	session["image"] = request.env["omniauth.auth"]["info"]["image"]
	      	session[:normal] = true
	      	session[:name] = normal.first_name<<" "<<normal.last_name
	      	redirect_to preferences_user_index_path
	      else
	      	sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      	set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	      	session["image"] = request.env["omniauth.auth"]["info"]["image"]
	      end
	    else # nunca entra
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
  end
end