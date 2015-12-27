class ColaboratorController < ApplicationController

# ========================================================

  def index
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
    @colaborator = Colaborator.find_by normalID: params[:id]
  end

# ========================================================

  def create
=begin
    @colaborator = Colaborator.new
    @colaborator.normalID = params[:normalID]
    @colaborator.promoterID = params[:promoterID]

    if @colaborator.save
      user = User.find(params[:normalID])
      redirect_to user
    else
      @colaborator.destroy
      render 'new' end
=end

    #{"email"=>"teste@teste.pt", "convite"=>"aaa"}
    @convite = ConviteColaborator.new
    @convite.promoterID = current_user.userID
    @convite.email = params[:email]
    @convite.hashID = Digest::MD5.hexdigest(params[:email].to_s+current_user.userID.to_s+Time.now.to_s)
    if @convite.save
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

    if Colaborator.delete_all(:normalID => params[:normalID])
      user = User.find(params[:normalID])
      redirect_to user
    else
      render 'edit'
    end

    if false
      @colaborator = Colaborator.find_by normalID: params[:id]
     
      if @colaborator.update(normalID: params[:id], promoterID: params[:promoterID])
        user = User.find(params[:normalID])
        redirect_to user
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
    if Colaborator.delete_all(:normalID => params[:id])
      user = User.find(params[:id])
      redirect_to user
    else
      render 'edit'
    end
  end

# ========================================================

end