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

    # =======================SE VEIO DE UM LINK PARA ACEITAR CONVITE ======================
    if params[:colaborator].present? && params[:email].present?
      if params[:email] == resource.email
        if ConviteColaborator.accept(params[:colaborator], params[:email])
          flash[:sucess] = "Convite aceite"
        else
          flash[:alert] = "Erro ao aceitar o convite"
        end
      else
        flash[:alert] = "Erro: O convite não foi enviado para o email desta conta"
      end
    else # ======================= SE VEIO DE OUTRO SITIO TIPO LOGIN/LOGIN_FB/REGISTER/REGISTER_FB ==========
      session[:back] = request.env['HTTP_REFERER']
    end
    
    normalID,promoterID = User.getUserType(resource)
    if normalID.present?
      if !session[:name].present?
        session[:name] = Normal.find_by(normalID: current_user.userID).first_name << " " << Normal.find_by(normalID: current_user.userID).last_name
        if Normal.find_by(normalID: current_user.userID).photo.thumb.present?
         session["image"] = Normal.find_by(normalID: current_user.userID).photo.thumb.url
        end
        if session[:back].present?
          if session[:back] != root_url && session[:back] != new_user_session_url
            return session[:back]
          end
        end
      end
    elsif promoterID.present?
      if !session[:name].present?
        promoter = Promoter.find_by(promoterID: current_user.userID)
        session[:name] = promoter.name
        return promoter_url(promoter)
      end
    elsif user_signed_in?
      if !session[:name].present?
        session[:name] = "Ocorreu um erro"
        return root_url
      end
    end
    return root_url
  end
end