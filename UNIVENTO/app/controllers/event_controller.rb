class EventController < ApplicationController
# ========================================================

	def show
    	begin
		  @event = Event.find(params[:id])
		  authorize! :read, @event, :message => "Evento indisponível"
		  @image = @event.image.all
		  if @event.activeDate > Time.now
		  	flash[:alert] = "Evento será publicado em: "<<@event.activeDate.to_s
		  end
		rescue ActiveRecord::RecordNotFound => e
		  flash[:alert] = "Evento indisponível"
		  redirect_to root_path
		  return
		end
 	end

# ========================================================

	def edit
    	@event = Event.find(params[:id])
    	authorize! :update, @event, :message => "Não tem autorização para editar este evento"
    	@category = Category.all
 	end

# ========================================================

	def update
		#render plain: params.inspect
		#return
		@event = Event.find(params[:id])
		@event.image.each do |img|
			File.delete("#{Rails.root}/public/uploads/image/image/"<<img.imageID.to_s<<"/"<<img["image"])
		end
		@event.image.delete_all
		@event.youtube.delete_all
		@event.spotify.delete_all
		@event.tags.delete_all
		@event.eventdate.delete_all
		create_or_update_event("update")
		return
	end

# ========================================================

 	def new
 		#render plain: params.inspect
		#return
 		@event = Event.new
 		authorize! :create, @event, :message => "Não tem autorização para criar eventos"
 		@category = Category.all
 		@image = Image.new
 		if Colaborator.find_by_normalID(current_user.userID)
 			@associacoes = Array.new
 			Colaborator.where(normalID: current_user.userID).each do |promoter|
 				@associacoes.push(Promoter.find_by_promoterID(promoter.promoterID).name)
 			end
 		end

		puts "new"
		puts flash.inspect
 	end

# ========================================================

 	def create
        @fail = false
 		@event = Event.new
 		create_or_update_event("new")
 		return
 	end

# ========================================================

	def create_or_update_event(tipo)
		#render plain: params.inspect
		#return
		event_params = params[:event]
 		@event.name = event_params[:name]
 		@event.descrition = event_params[:descrition]
 		@event.preco = event_params[:preco]
 		@event.categoryID = params[:category].to_i

 		if tipo == "new"
	 		@event.averageRate=0
	 		@event.numRates=0
	 		if Promoter.find_by_promoterID(current_user.userID)
	 			@event.propose=false
	 			@event.promoterID = current_user.userID
	 			@event.normalID = nil
	 		elsif Colaborator.find_by_normalID(current_user.userID)
	 			@event.propose=true
#<!> 			#escolher o id do promotor conforme o valor do input referente à associação
				@event.promoterID = Promoter.where(name: params[:promoter]).take.promoterID
				@event.normalID = current_user.userID
	 		end
 		end
 		
 		if params["activeDate"].present?
        	@event.activeDate = params["activeDate"]
        else @event.activeDate = Time.now
        end

       	if saveOrDestroy(@event) 
       		return 
       	end
        
        if params[:tags].present?
	        params[:tags].each do |tag|
	            eventTag = EventTags.new
	            eventTag.eventID = @event.eventID
	            eventTag.tagsID=tag.to_i
	     
	            if saveOrDestroy(eventTag) 
	            	return 
	            end
	        end
	    end

	    if params[:youtube].present?
	        params[:youtube].each do |link|
	        	if link.present?
		            youtube = Youtube.new
		            youtube.videoID="https://www.youtube.com/embed/" + link.sub("https://www.youtube.com/watch?v=", "").gsub("&","?")
		            youtube.eventID=@event.eventID
					#y:		https://www.youtube.com/watch?v=pxMy-QB-yP4
					#ye:	https://www.youtube.com/embed/pxMy-QB-yP4
		            if saveOrDestroy(youtube) 
		            	return 
		            end
		        end
	        end
	    end
	    if params[:spotify].present?
	        params[:spotify].each do |link|
	        	if link.present?
		            spotify = Spotify.new
		            spotify.playListLink = "https://embed.spotify.com/?uri=spotify:" + link.sub("https://open.spotify.com/","").gsub("/",":")
		            spotify.eventID=@event.eventID
					#s: 	https://open.spotify.com/track/5cR7culxUEPLhzIC0KWAH1
					#se:	https://embed.spotify.com/?uri=spotify:track:5cR7culxUEPLhzIC0KWAH1
		            if saveOrDestroy(spotify) 
		            	return 
		            end
		        end
	        end
	    end

	    if params[:dates].present?
		    params[:dates].each_with_index do |date, k|
		        eventDate = EventDate.new
		        if params[:dates][k.to_s]["startDate"].present?
		        	eventDate.startDate = params[:dates][k.to_s]["startDate"]
		        else eventDate.startDate = Time.now
		        end

		        if params[:dates][k.to_s]["endDate"].present?
		        	eventDate.endDate = params[:dates][k.to_s]["endDate"]
		        else eventDate.endDate = Time.now
		        end

		        eventDate.eventID=@event.eventID
		        eventDate.preco=params["price"][k].to_f
		       	eventDate.descrition = params[:page]["info"<<k.to_s]
		        if params[:dates][k.to_s]["address"].present?
		        	local = Local.new
			        local.address=params[:dates][k.to_s]["address"]
			        local.latitude = params[:dates][k.to_s]["latitude"]
			        local.longitude= params[:dates][k.to_s]["longitude"]
			        if saveOrDestroy(local) 
			          	return 
			        end
			        eventDate.localID= local.localID
		        end

		        if saveOrDestroy(eventDate) 
		          	return 
		        end
		    end
		end

        if params[:image].present?
	        params[:image]['image'].each_with_index do |a,index|
	        	if index <10
			        @image = @event.image.create!(:image => a ,:eventID => @event.eventID)
			    end
	        end
    	end
        redirect_to @event
	end

# ========================================================
	def index		

		@eventDates = Array.new
		eventDates2 = Array.new

		# ------------------- DB query -------------------------

		# Find events ordered by most closest date for the next 4 years from now.
		eventDates1 = EventDate.where(startDate: (Time.now)..Time.now + 1461.day).order(startDate: :asc)

		# ----- Active Events & remove duplicated --------------

		eventsID = Array.new

		eventDates1.each do |eventDate|
			if eventDate.event.activeDate < Time.now && !eventDate.event.propose && eventDate.event.propose != nil
				if !eventsID.include?(eventDate.eventID)
					@eventDates.push(eventDate)
				end
				eventsID.push(eventDate.eventID)
			end
		end

		# ------------------- Filters -------------------------

		promoter = params[:promoter]
		institution = params[:institution]
		category = params[:category]
		date = params[:date]
		local = params[:local]
		pageLink = ""

		if promoter != nil
			@eventDates.each do |eventDate|
				if eventDate.event.promoter.name.upcase == promoter.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
			pageLink = pageLink + "&promoter=" + promoter
		end

		if institution != nil
			@eventDates.each do |eventDate|
				if eventDate.event.promoter.institution.upcase == institution.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
			pageLink = pageLink + "&institution=" + institution
		end
		
		if category != nil
			@eventDates.each do |eventDate|
				if eventDate.event.category.name.upcase == category.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
			pageLink = pageLink + "&category=" + category
		end

		if local != nil
			@eventDates.each do |eventDate|
				if eventDate.local.address.upcase.include?(local.upcase)
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
			pageLink = pageLink + "&local=" + local
		end

		# ------------------- Preferences -------------------------

		prefs = params[:prefs]

		if(prefs != nil)
			if current_user != nil
				user = User.find(current_user.id.to_s)
				ambianceCategoryID = Category.find_by(name: "Ambiente").categoryID
				musicCategoryID = Category.find_by(name: "Música").categoryID
				nightCategoryID = Category.find_by(name: "Noturno").categoryID

				tagsPrefs = NormalTags.all
				categoriesPrefs = NormalCategory.all
				nightEventsPrefs = NormalCategory.where(categoryID: nightCategoryID)

				if categoriesPrefs.length != 0
					@eventDates.each do |eventDate|
						categoriesPrefs.each do |categoryPref|
							if eventDate.event.categoryID == categoryPref.categoryID
								eventDates2.push(eventDate)
							end
						end
					end
					@eventDates = eventDates2.clone
					eventDates2.clear
				end

				if tagsPrefs.length != 0
					@eventDates.each do |eventDate|
						eventDate.event.tags.each do |eventTag|
							tagsPrefs.each do |tagsPref|
								if eventTag.tagsID == tagsPref.tagsID
									eventDates2.push(eventDate)
								end
							end
						end
					end
					@eventDates = eventDates2.clone
					eventDates2.clear
				end
			end
			pageLink = pageLink + "&prefs=1"
		end

		# ------------------- Paginate by 18 events -------------------------

		maxShowCount = 18
		@listSize = @eventDates.length
		@startCount = 0
		@endcount = @listSize - 1
		@showCount = 0
		@listCount = 0

		# ------ Find pages count ----------

		@maxPage = ((@listSize.to_f / maxShowCount.to_f).to_f).ceil

		@page = params[:page].to_i
		if @page == nil
			@page = 1
		end

		if @page < 1
			@page = 1
		end

		if @page > @maxPage
			@page = @maxPage
		end

		# ------ Find List indexs for 1 page ----------

		if @listSize > maxShowCount
			@startCount = (@page - 1) * maxShowCount
			@endcount = @startCount + maxShowCount - 1
			if @endcount > @listSize - 1
				@endcount = @listSize - 1
			end
		end

		# ------ Create pages links ----------

		@pagesLinks = Array.new

		for i in 1..@maxPage
			link = "event?page=#{i}"
			@pagesLinks.push(link + pageLink)
		end

		# ------ Create a page of events ----------

		@eventDates.each do |eventDate|
			if @listCount >= @startCount && @listCount <= @endcount
				eventDates2.push(eventDate)
				@showCount = @showCount + 1
			end
			@listCount = @listCount + 1
		end
		@eventDates = eventDates2

	end

# ========================================================

    def saveOrDestroy(object)
    	begin
        	object.save! # é suposto todos os erros serem verificados em javascript e não dar erro aqui
        	return false
        rescue Exception
        	@event.destroy
        	@fail = true
            flash[:alert] = "Erro ao criar o evento, por favor verifique os dados introduzidos"
            @category = Category.all
            render new_event_path
            return true
        end
    end

# ========================================================

	def search
		numEventos = 16
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

		@events = Event.where('name LIKE ?', "%"+params[:search]+"%").offset(numEventos*(params[:numPage].to_i-1)).first(numEventos)

		while @events.blank?
			params[:numPage]=params[:numPage].to_i-1
			@events = Event.where('name LIKE ?', "%"+params[:search]+"%").offset(numEventos*(params[:numPage].to_i-1)).first(numEventos)
		end
	end

# ========================================================

	def accept
		@event = Event.find(params[:id])

		promoterID = @event.promoterID.to_s

		if @event.update_attribute(:propose, false)
			redirect_to root_path+"promoter/"+promoterID
		else
			redirect_to @event
		end
	end

# ========================================================

	def destroy
		@event = Event.find(params[:id])
		promoterID = @event.promoterID.to_s

		if Event.delete(params[:id])
			redirect_to root_path+"promoter/"+promoterID
		else
			redirect_to @event
		end
	end

# ========================================================

	def registration
		@event = Event.find(params[:event_id])
		@criarInscricao=false;
		@isPromoter=false;
		if user_signed_in?
			if Promoter.find_by_promoterID(current_user.userID).present? 
				if Promoter.find(current_user.userID).promoterID == @event.promoterID
					@isPromoter=true;
					if !@event.docsID.present?
						@criarInscricao=true;
					end
				end
			end
		end

		if !@criarInscricao && !@event.docsID.present?
			flash[:alert]= "Inscrição indisponível"
		end

		respond_to do |format|
	      format.html
	      format.json { 
	      	if params[:accao] == "getEventInfo"
	      		render :json => [@event.name, @event.eventID,@event.docsID,current_user.email].to_json 
	      	elsif params[:accao] == "saveDocsID"
	      		@event.docsID = params[:docsID]
	      		render :json => @event.save!.to_json
	      	end
	      }
	    end
	end
# ========================================================

end