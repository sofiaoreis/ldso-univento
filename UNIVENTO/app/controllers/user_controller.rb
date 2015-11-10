class UserController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    user = User.new
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    if user.save
      normal = Normal.new
      normal.first_name = params[:first_name]
      normal.last_name = params[:last_name]
      normal.gender = params[:gender]
      normal.birthday = Date.civil(*params[:birthday].sort.map(&:last).map(&:to_i))
      normal.normalID = user.userID
      if normal.save
        redirect_to user
      else render 'new' end
    else render 'new' end
  end

  def show
    @user = User.find(params[:id])
  end

  def login 
    user = User.where(email: params[:user][:email]).take
    if user.valid_password?(params[:user][:password])
      sign_in(user)
      redirect_to "/homepage/index"
    else
      redirect_to "/homepage/index"
    end
  end

end

