class PromoterController < ApplicationController

# ========================================================

  def index
    @promoters = Promoter.all
    #@users = User.all
  end

# ========================================================

  def show

    # ------------------- DB query -------------------------
    
    @user = User.find(params[:id])
    @promoter = Promoter.find(params[:id])
    @colaborators = Colaborator.where(:promoterID => params[:id])

    @owner = user_signed_in? && current_user.userID.to_i == params[:id].to_i

    # Find events ordered by most closest date for the next 4 years from now.
    eventDates1 = EventDate.where(startDate: (Time.now)..Time.now + 1461.day).order(startDate: :asc)

    # ----- Visible Events --------------

    @shownEventDates = Array.new

    eventsID = Array.new

    eventDates1.each do |eventDate|
      if eventDate.event.activeDate < Time.now && !eventDate.event.propose && eventDate.event.propose != nil && eventDate.event.promoterID == params[:id].to_i
        if !eventsID.include?(eventDate.eventID)
          @shownEventDates.push(eventDate)
        end
        eventsID.push(eventDate.eventID)
      end
    end

    # ----- Hidden Events --------------

    @hiddenEventDates = Array.new

    eventsID = Array.new

    eventDates1.each do |eventDate|
      if eventDate.event.activeDate > Time.now && !eventDate.event.propose && eventDate.event.propose != nil && eventDate.event.promoterID == params[:id].to_i
        if !eventsID.include?(eventDate.eventID)
          @hiddenEventDates.push(eventDate)
        end
        eventsID.push(eventDate.eventID)
      end
    end

    # ----- Proposed Events --------------
    
    @proposedEventDates = Array.new

    eventsID = Array.new

    eventDates1.each do |eventDate|
      if eventDate.event.activeDate > Time.now && eventDate.event.propose && eventDate.event.propose != nil && eventDate.event.promoterID == params[:id].to_i
        if !eventsID.include?(eventDate.eventID)
          @proposedEventDates.push(eventDate)
        end
        eventsID.push(eventDate.eventID)
      end
    end

    # ----- Obsoleted Proposed Events --------------

    eventDates2 = EventDate.order(startDate: :asc)
    
    @ObsoletedProposedEventDates = Array.new

    eventsID = Array.new

    eventDates2.each do |eventDate|
      if eventDate.event.activeDate < Time.now && eventDate.event.propose && eventDate.event.propose != nil && eventDate.event.promoterID == params[:id].to_i
        if !eventsID.include?(eventDate.eventID)
          @ObsoletedProposedEventDates.push(eventDate)
        end
        eventsID.push(eventDate.eventID)
      end
    end

  end

# ========================================================

  def new
    @user = User.new
  end

# ========================================================

  def edit
    if user_signed_in? && current_user.userID.to_i == params[:id].to_i
      @user = User.find(params[:id])
      @promoter = Promoter.find(params[:id])
    else
      flash[:alert] = "Não tem permissões para editar este promotor"
      redirect_to root_path
    end
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
    if user_signed_in? && current_user.userID.to_i == params[:id].to_i
      @user = User.find(params[:id])
      @promoter = Promoter.find(params[:id])

      if @promoter.update(name: params[:name], institution: params[:institution], website: params[:website], contact: params[:contact])
        redirect_to @promoter
      else
        render 'edit'
      end
    else
      flash[:alert] = "Deve fazer login para poder editar o seu perfil de promotor"
      redirect_to root_path
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