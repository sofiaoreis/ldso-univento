class UserController < ApplicationController

  # ========================================================

  def index
    @normals = Normal.all
    @promoters = Promoter.all
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

  # ========================================================

  def show

    @user = User.find_by_userID(params[:id])

    if @user.present?

      @colaborator = Colaborator.find_by normalID: params[:id]
      @promoter = Promoter.find_by promoterID: params[:id]

      if @promoter == nil

        # -------------------  Preferences  -----------------------------------
        ambianceCategoryID = Category.find_by(name: "Ambiente").categoryID
        musicCategoryID = Category.find_by(name: "Música").categoryID
        nightCategoryID = Category.find_by(name: "Noturno").categoryID

        @tagsPrefs = NormalTags.all
        @categoriesPrefs = NormalCategory.all
        @nightEventsPrefs = NormalCategory.where(categoryID: nightCategoryID)

        # -------------------  Friendships  -----------------------------------
        @alreadyFriend = false
        @maybeFriend = false
        @friends = Array.new
        @commonFriends = Array.new
        @friendRequestsSended = Array.new
        @friendRequestsReceived = Array.new

        sendedFriendships = Friendship.where(requesterNormalID: params[:id], :friends => [nil, false])
        receivedFriendships = Friendship.where(requestedNormalID: params[:id], :friends => [nil, false])
        friends1 = Friendship.where(requesterNormalID: params[:id], :friends => [true])
        friends2 = Friendship.where(requestedNormalID: params[:id], :friends => [true])

        sendedFriendships.each do |friend|
          @friendRequestsSended.push(Normal.find_by normalID: friend.requestedNormalID)
          if user_signed_in? && friend.requestedNormalID == current_user.userID.to_i
            @alreadyFriend = true
            @maybeFriend = true
          end
        end
        receivedFriendships.each do |friend|
          @friendRequestsReceived.push(Normal.find_by normalID: friend.requesterNormalID)
          if user_signed_in? && friend.requesterNormalID == current_user.userID.to_i
            @alreadyFriend = true
            @maybeFriend = true
          end
        end

        friends1.each do |friend|
          @friends.push(Normal.find_by normalID: friend.requestedNormalID)
          if user_signed_in? && friend.requestedNormalID == current_user.userID.to_i
            @alreadyFriend = true
          end
        end
        friends2.each do |friend|
          @friends.push(Normal.find_by normalID: friend.requesterNormalID)
          if user_signed_in? && friend.requesterNormalID == current_user.userID.to_i
            @alreadyFriend = true
          end
        end

        # -----------  Common Friends  -----------
        if user_signed_in? && current_user.userID.to_i != params[:id].to_i
          currentUserFriends1 = Friendship.where(requesterNormalID: current_user.userID, :friends => [true])
          currentUserFriends2 = Friendship.where(requestedNormalID: current_user.userID, :friends => [true])

          currentUserFriends = Array.new
          currentUserFriends1.each do |friend|
            currentUserFriends.push(Normal.find_by normalID: friend.requestedNormalID)
          end
          currentUserFriends2.each do |friend|
            currentUserFriends.push(Normal.find_by normalID: friend.requesterNormalID)
          end

          @friends.each do |friend|
            currentUserFriends.each do |currentUserFriend|
              if friend.normalID == currentUserFriend.normalID
                @commonFriends.push(currentUserFriend)
              end
            end
          end
        end

        @assistedEvents = Array.new
        registrations = Registration.where(:normalID => @user.userID)

        registrations.each do |registration|
          @assistedEvents.push(Event.find_by eventID: registration.eventID)
        end

      end
    else
      flash[:alert] = "User não existe"
      redirect_to root_path
    end
  end

  # ========================================================

  def defineUserType
  end

  # ========================================================
  
  def preferences
    if user_signed_in? && current_user.userID.to_i == params[:id].to_i
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
    else
      flash[:alert] = "Deve fazer login para poder alterar as suas preferencias"
      redirect_to root_path
    end
  end

  # ========================================================
  
  def savePreferences

    #render plain: params.inspect
    #return
    if user_signed_in? && current_user.userID.to_i == params[:id].to_i

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

      flash[:sucess] = "As suas preferencias foram guardadas com sucesso"
      user = User.find(userID)
      redirect_to user
      return
    else
      flash[:alert] = "Deve fazer login para poder guardar as suas preferencias"
      redirect_to root_path
    end
  end

  # ========================================================

  def destroy
    user = User.find_by_userID(params[:id])

    if user.present?
      user.update_column("banned",true)
      flash[:sucess] = "UserID: "+user.userID.to_s+" banido"
    end
    redirect_to root_path
  end

  # ========================================================

  def requestfriend
    if user_signed_in?
      friendShip = Friendship.new
      friendShip.friends = false
      friendShip.requesterNormalID = params[:sender]
      friendShip.requestedNormalID = params[:receiver]

      if !friendShip.save
        flash[:alert] = "Pedido de amizade não foi enviado"
        friendShip.destroy
      else
        flash[:sucess] = "Pedido de amizade enviado"
      end
      redirect_to user_path(params[:receiver])
      return
    else
      flash[:alert] = "Deve fazer login para poder enviar pedidos de amizade"
      redirect_to root_path
    end
  end

  # ========================================================

  def acceptfriend
    if user_signed_in?
      friendship = Friendship.where(:requesterNormalID => params[:sender], :requestedNormalID => params[:receiver])

      if friendship.present?
        if !Friendship.delete_all(:requesterNormalID => params[:sender], :requestedNormalID => params[:receiver])
          flash[:alert] = "Pedido de amizade não foi aceite"
          redirect_to current_user
        end

        newFriendship = Friendship.new
        newFriendship.friends = true
        newFriendship.requesterNormalID = params[:sender]
        newFriendship.requestedNormalID = params[:receiver]

        if !newFriendship.save
          flash[:alert] = "Pedido de amizade não foi aceite"
          newFriendship.destroy
        else
          flash[:sucess] = "Pedido de amizade aceite"
        end
      else
        flash[:alert] = "Pedido de amizade não existe"
      end
      redirect_to current_user
      return
    else
      flash[:alert] = "Deve fazer login para poder aceitar pedidos de amizade"
      redirect_to root_path
    end
  end

  # ========================================================

  def rejectfriend
    if user_signed_in?
      if !Friendship.delete_all(:requesterNormalID => params[:sender], :requestedNormalID => params[:receiver])
        flash[:alert] = "Pedido de amizade não foi rejeitado"
      else
        flash[:sucess] = "Pedido de amizade rejeitado"
      end
      redirect_to current_user
      return
    else
      flash[:alert] = "Deve fazer login para poder rejeitar pedidos de amizade"
      redirect_to root_path
    end
  end

  # ========================================================

  def cancelfriend
    if user_signed_in?
      if !Friendship.delete_all(:requesterNormalID => params[:sender], :requestedNormalID => params[:receiver])
        flash[:alert] = "Pedido de amizade não pode ser anulado"
      else
        flash[:sucess] = "Pedido de amizade anulado"
      end
      redirect_to current_user
      return
    else
      flash[:alert] = "Deve fazer login para poder anular pedidos de amizade"
      redirect_to root_path
    end
  end

  # ========================================================

  def deletefriend
    if user_signed_in?
      if Friendship.delete_all(:requesterNormalID => params[:id1], :requestedNormalID => params[:id2])
        flash[:sucess] = "Amizade anulada"
      end

      if Friendship.delete_all(:requesterNormalID => params[:id2], :requestedNormalID => params[:id1])
        flash[:sucess] = "Amizade anulada"
        redirect_to current_user
        return
      end

      flash[:alert] = "Amizade não pode ser anulada"
      redirect_to current_user
      return
    else
      flash[:alert] = "Deve fazer login para poder anular uma amizade"
      redirect_to root_path
    end
  end

  # ========================================================

  def search
    numNormals = 16
    if !params[:numPage].present?
      params[:numPage]=1
    end
    if params[:commit].present?
      if params[:commit]==">"
        params[:numPage]=params[:numPage].to_i+1
      elsif params[:commit]=="<"
        params[:numPage]=params[:numPage].to_i-1
      end
    end

    if params[:numPage]<1
      params[:numPage]=1
    end

    @normals = Array.new

    if params[:search].present?
      @normals = Normal.where("first_name LIKE ? OR last_name LIKE ?", "%"+params[:search]+"%", "%"+params[:search]+"%").offset(numNormals*(params[:numPage].to_i-1)).first(numNormals)

      if @normals.length != 0
        while @normals.blank?
          params[:numPage]=params[:numPage].to_i-1
          @normals = Normal.where("first_name LIKE ? OR last_name LIKE ?", "%"+params[:search]+"%", "%"+params[:search]+"%").offset(numNormals*(params[:numPage].to_i-1)).first(numNormals)
        end
      end
    end
  end

  # ========================================================

end