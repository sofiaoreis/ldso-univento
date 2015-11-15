class PromoterController < ApplicationController

# ========================================================

  def index
    @promoters = Promoter.all
    #@users = User.all
  end

# ========================================================

  def show
    @user = User.find(params[:id])
  end

# ========================================================

  def new
    @user = User.new
  end

# ========================================================

  def edit
    @user = User.find(params[:id])
  end

# ========================================================

  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]

    if @user.save
      @promoter = Promoter.new
      @promoter.name = params[:name]
      @promoter.institution = params[:institution]
      @promoter.website = params[:website]
      @promoter.contact = params[:contact]
      @promoter.promoterID = @user.userID

      if @promoter.save
        redirect_to @promoter
      else
        @promoter.destroy
        @user.destroy
        render 'new'
      end

    else
      #@user.destroy
      render 'new' end
  end

# ========================================================
 
  def update
    @user = User.find(params[:id])
   
    if @user.update(email: params[:user][:email], password: params[:user][:password])
      @promoter = Promoter.find(params[:id])
      
      if @promoter.update(name: params[:name], institution: params[:institution], website: params[:website], contact: params[:contact])
        redirect_to @promoter
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

# ========================================================

  def login 
    user = User.where(email: params[:user][:email]).take

    if user.valid_password?(params[:user][:password])
      sign_in(user)
      redirect_to "/homepage/index"
    else
      redirect_to "/homepage/index"
    end
  end

# ========================================================

end