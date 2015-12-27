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
    @colaborator = Colaborator.new
    authorize! :create, @colaborator
  end

# ========================================================

  def edit
    @colaborator = Colaborator.find_by normalID: params[:id]
  end

# ========================================================

  def create
    @colaborator = Colaborator.new
    @colaborator.normalID = params[:normalID]
    @colaborator.promoterID = params[:promoterID]

    if @colaborator.save
      user = User.find(params[:normalID])
      redirect_to user
    else
      @colaborator.destroy
      render 'new' end
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