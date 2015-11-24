class EventController < ApplicationController

# ========================================================

	def show
    	begin
		  @event = Event.find(params[:id])
		  @image = @event.image.all
		rescue ActiveRecord::RecordNotFound => e
		  flash[:alert] = "Este evento não existe"
		  redirect_to root_path
		end
 	end

# ========================================================


 	def new
 		if !session[:promoter].present?
 			flash[:alert] = "Não tem autorização para criar eventos"
 			redirect_to root_path
 		end
 		@event = Event.new
 		@category = Category.all
 		@image = Image.new
 	end

# ========================================================

	def update
		@event = Event.find(params[:id])
	end

# ========================================================

	def edit
    	@event = Event.find(params[:id])
    	@category = Category.all
    	@image = @event.image
 	end


# ========================================================

 	def create
 		#render plain: params.inspect
 		#return
        @fail = false
 		@event = Event.new
 		event_params = params[:event]
 		@event.name = event_params[:name]
 		@event.descrition = event_params[:descrition]
 		@event.preco = event_params[:preco]
 		@event.promoterID = current_user.userID
 		@event.categoryID = params[:category].to_i
 		@event.averageRate=0
 		@event.numRates=0
 		@event.propose=false
        @event.activeDate = (params["activeDate"]["activeDate(3i)"]<<"-"<<params["activeDate"]["activeDate(2i)"]<<"-"<<params["activeDate"]["activeDate(1i)"]<<" "<<params["activeDate"]["activeDate(4i)"]<<":"<<params["activeDate"]["activeDate(5i)"])

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
	            youtube = Youtube.new
	            youtube.videoID=link
	            youtube.eventID=@event.eventID
	            
	            if saveOrDestroy(youtube) 
	            	return 
	            end
	        end
	    end
	    if params[:spotify].present?
	        params[:spotify].each do |link|
	            spotify = Spotify.new
	            spotify.playListLink=link
	            spotify.eventID=@event.eventID
	            
	            if saveOrDestroy(spotify) 
	            	return 
	            end
	        end
	    end
=begin
	    if params[:address].present?
	        params[:address].each_with_index do |address, i|
	          local = Local.new
	          local.address=address
	          local.latitude = params[:latitude].index(i)
	          local.longitude= params[:longitude].index(i)
	          
	          if saveOrDestroy(local) 
	          	return 
	          end
	        end
	    end
=end
	    if params[:dates].present?
		    params[:dates].each_with_index do |date, k|
		        eventDate = EventDate.new
		        eventDate.startDate = (params[:dates][k.to_s]["startDate(1i)"] << "-" << params[:dates][k.to_s]["startDate(2i)"]<< "-" << params[:dates][k.to_s]["startDate(3i)"]<< " "<<params[:dates][k.to_s]["startDate(4i)"]<<":"<<params[:dates][k.to_s]["startDate(5i)"])
		        eventDate.endDate = (params[:dates][k.to_s]["endDate(1i)"] << "-" << params[:dates][k.to_s]["endDate(2i)"]<< "-" << params[:dates][k.to_s]["endDate(3i)"]<< " "<<params[:dates][k.to_s]["endDate(4i)"]<<":"<<params[:dates][k.to_s]["endDate(5i)"])
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
		        else
		        	eventDate.localID = params[:local][k].to_i
		        end

		        if saveOrDestroy(eventDate) 
		          	return 
		        end
		    end
		end
        if params[:image].present?
	        params[:image]['image'].each do |a|
	          @image = @event.image.create!(:image => a ,:eventID => @event.eventID)
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
			if eventDate.event.activeDate < Time.now && eventDate.event.propose
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

		if promoter != nil
			@eventDates.each do |eventDate|
				if eventDate.event.promoter.name.upcase == promoter.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
		end

		if institution != nil
			@eventDates.each do |eventDate|
				if eventDate.event.promoter.institution.upcase == institution.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
		end
		
		if category != nil
			@eventDates.each do |eventDate|
				if eventDate.event.category.name.upcase == category.upcase
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
		end

		if local != nil
			@eventDates.each do |eventDate|
				if eventDate.local.address.upcase.include?(local.upcase)
					eventDates2.push(eventDate)
				end
			end
			@eventDates = eventDates2.clone
			eventDates2.clear
		end

		# ------------------- Limit to 18 events -------------------------

		maxShowCount = 18
		@showCount = 0
		@listCount = 0

		@eventDates.each do |eventDate|
			if @showCount < maxShowCount
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
end
