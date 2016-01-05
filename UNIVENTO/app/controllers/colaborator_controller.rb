class ColaboratorController < ApplicationController

# ========================================================

  def index
    flash[:alert] = "Not implemented"
    redirect_to root_path and return
    @colaborators = Colaborator.all
  end

# ========================================================

  def show
    @colaborator = Colaborator.find_by normalID: params[:id]
  end

# ========================================================

  def new
    #@colaborator = Colaborator.new
    @convite = ConviteColaborator.new
    authorize! :create, Colaborator
  end

# ========================================================

  def edit
    if user_signed_in?
      @colaborator = Colaborator.find_by normalID: params[:id]
    else
      flash[:alert] = "Não tem permissões para editar colaboradores"
      redirect_to root_path
    end
  end

# ========================================================

  def create

    user = User.where(:email => params[:email]).take
    if user.present?
      normal = Normal.find_by_normalID(user.userID)
      if normal.present?
        if Colaborator.where("normalID = ? AND promoterID = ?",normal.normalID, current_user.userID).present?
          flash[:notice] = "Este utilizador já é seu colaborador"
          redirect_to root_path and return
        end
      end
    end

    @convite = ConviteColaborator.new
    @convite.promoterID = current_user.userID
    @convite.email = params[:email]
    @convite.hashID = Digest::MD5.hexdigest(params[:email].to_s+current_user.userID.to_s+Time.now.to_s)
    if @convite.save
      email = @convite.email
      promoter = Promoter.find_by_promoterID(current_user.userID).name
      url =  new_user_session_url+"?colaborator="+@convite.hashID+"&email="+@convite.email
      UserMailer.convite_email(email, promoter, url, params[:convite]).deliver_now
      flash[:notice] = "Convite enviado"
      redirect_to root_path
      return
    else 
      flash[:notice] = "Erro criar convite"
      render 'new'
    end
  end

# ========================================================
 
  def update

    if user_signed_in?
      if Colaborator.delete_all(:normalID => params[:normalID])
        user = User.find(params[:normalID])
        flash[:sucess] = "Colaborador despromovido com sucesso"
        redirect_to user
        return
      else
        render 'edit'
      end
    else
      flash[:alert] = "Não tem permissões para despromover colaboradores"
      redirect_to root_path
      return
    end

    if false
      @colaborator = Colaborator.find_by normalID: params[:id]
     
      if @colaborator.update(normalID: params[:id], promoterID: params[:promoterID])
        user = User.find(params[:normalID])
        redirect_to user
        return
      else
        render 'edit'
      end
    end

  end

# ========================================================

  def login
  end

# ========================================================

  def destroy
    if user_signed_in?
      if Colaborator.delete_all(:normalID => params[:id])
        user = User.find(params[:id])
        flash[:sucess] = "Colaborador removido com sucesso"
        redirect_to user
        return
      else
        render 'edit'
      end
    else
      flash[:alert] = "Não tem permissões para remover colaboradores"
      redirect_to root_path
      return
    end
  end

# ========================================================

end