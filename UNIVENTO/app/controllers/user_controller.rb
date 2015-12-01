class UserController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  attr_reader   :errors

  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    if @user.save
      normal = Normal.new
      if !params[:first_name].present?
        @user.errors.add("first_name", "Inserir o primeiro nome")
        @user.destroy
        render 'new'
        return
      end 
      if !params[:last_name].present?
        @user.errors.add("last_name", "Inserir o último nome")
        @user.destroy
        render 'new'
        return
      end 
      normal.first_name = params[:first_name]
      normal.last_name = params[:last_name]
      normal.gender = params[:gender]
      normal.birthday = Date.civil(*params[:birthday].sort.map(&:last).map(&:to_i))
      normal.normalID = @user.userID
      if normal.save
        flash[:notice] = "Conta criada com sucesso! Pode agora fazer login!"
        redirect_to root_path
      else 
        @user.destroy
        render 'new'
      end
    else render 'new' end
  end

  def show
    @user = User.find(params[:id])
    @colaborator = Colaborator.find_by normalID: params[:id]
  end

  def defineUserType
  end
end

