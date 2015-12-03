class UserController < ApplicationController

  # ========================================================

  def index
    @users = User.all
  end

  # ========================================================
  
  def new
    @user = User.new
  end

  # ========================================================

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
    @promoter = Promoter.find_by promoterID: params[:id]

    if @promoter == nil
      ambianceCategoryID = Category.find_by(name: "Ambiente").categoryID
      musicCategoryID = Category.find_by(name: "Música").categoryID
      nightCategoryID = Category.find_by(name: "Noturno").categoryID

      @tagsPrefs = NormalTags.all
      @categoriesPrefs = NormalCategory.all
      @nightEventsPrefs = NormalCategory.where(categoryID: nightCategoryID)
    end

  end

  # ========================================================

  def defineUserType
  end

  # ========================================================
  
  def preferences

    @user = User.find(params[:id])
    categories1 = Category.all
    @ambianceTags = Category.find_by(name: "Ambiente").tags
    @musicTags = Category.find_by(name: "Música").tags

    @categories = Array.new

    categories1.each do |category|
      if category.name != 'Ambiente' && category.name != 'Música' && category.name != 'Noturno'
        @categories.push(category)
      end
    end

  end

  # ========================================================
  
  def savePreferences

    #render plain: params.inspect
    #return

    ambianceTags = params[:ambianceTags]
    musicTags = params[:musicTags]
    categories = params[:categories]
    eventTime = params[:eventTime]
    userID = params[:id].to_i

    #--------- Reset NormalUser Preferences -----------

    if !NormalTags.delete_all(:normalID => userID)
      render 'preferences'
    end

    if !NormalCategory.delete_all(:normalID => userID)
      render 'preferences'
    end

    #--------- Save Ambiance Preferences -----------

    if ambianceTags != nil      
      ambianceTags.each do |ambianceTag|
        ambianceTagPref = NormalTags.new
        ambianceTagPref.normalID = userID
        ambianceTagPref.tagsID = ambianceTag.to_i

        if !ambianceTagPref.save
          render 'preferences'
        end
      end
    end

    #--------- Save Music Preferences -----------

    if musicTags != nil
      musicTags.each do |musicTag|
        musicTagPref = NormalTags.new
        musicTagPref.normalID = userID
        musicTagPref.tagsID = musicTag.to_i

        if !musicTagPref.save
          render 'preferences'
        end
      end
    end

    #--------- Save Categories Preferences -----------

    if categories != nil
      categories.each do |category|
        categoryPref = NormalCategory.new
        categoryPref.normalID = userID
        categoryPref.categoryID = category.to_i

        if !categoryPref.save
          render 'preferences'
        end
      end
    end

    #--------- Save Night Events Preferences -----------

    if eventTime != nil && eventTime = "nightTime"
      nightCategoryID = Category.find_by(name: "Noturno").categoryID
      categoryPref = NormalCategory.new
        categoryPref.normalID = userID
        categoryPref.categoryID = nightCategoryID

        if !categoryPref.save
          render 'preferences'
        end
    end

    user = User.find(userID)
    redirect_to user
  end

  # ========================================================

end