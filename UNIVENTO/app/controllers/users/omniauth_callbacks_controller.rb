class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    
	    if @user.persisted? #entra sempre aqui 
	      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	      session["image"] = request.env["omniauth.auth"]["info"]["image"]
	    else # nunca entra
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
  end
end