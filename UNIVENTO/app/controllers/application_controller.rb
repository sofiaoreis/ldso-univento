class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :null_session
#=begin
	rescue_from CanCan::AccessDenied do |exception|
	    redirect_to root_url, :alert => exception.message
	end
#=end
	def after_sign_in_path_for(resource)
    if resource.banned == true
      reset_session
      flash[:alert] = "Você foi banido"
    end


    if params[:colaborator].present? && params[:email].present?
      if params[:email] == resource.email
        if ConviteColaborator.accept(params[:colaborator], params[:email])
          flash[:sucess] = "Convite aceite"
        else
          flash[:alert] = "Erro ao aceitar o convite"
        end
      else
        flash[:alert] = "Erro ao aceitar o convite"
      end
    end
  	session[:normal],session[:promoter] = User.getUserType(resource)
  	root_path
  end
end