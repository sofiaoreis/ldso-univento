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
 		@event = Event.new
 		@category = Category.all
 		@image = Image.new
 	end

# ========================================================

	def update
	end

# ========================================================

 	def create
 		#{
 		#	"utf8"=>"✓", 
 		#	"authenticity_token"=>"aclVkYcUEqhCdBC6l0yYHDLrvRXsThC8PGy15lewduwanw8y92k20YwJfMbT7h9ISncqudgZOBYZKf8oEX8IEw==", 
 		#	"event"=>
 		#		{
 		#			"name"=>"", 
 		#			"descrition"=>""
 		#		}, 
 		#	"category"=>"#<Category:0x007f950ff00d88>",
 		#	"tags"=>"#<Tags:0x007f950ff00d88>",
 		#	"youtube"=>["", "", ""], 
 		#	"spotify"=>["", "", ""], 
 		#	"address"=>["", "", ""], 
 		#	"latitude"=>["", "", ""], 
 		#	"longitude"=>["", "", ""], 
 		#	"dates"=>{
 		#		"0"=>{"startDate(3i)"=>"12", "startDate(2i)"=>"11", "startDate(1i)"=>"2015", "endDate(3i)"=>"12", "endDate(2i)"=>"11", "endDate(1i)"=>"2015"}, 
 		#		"1"=>{"startDate(3i)"=>"20", "startDate(2i)"=>"11", "startDate(1i)"=>"2015", "endDate(3i)"=>"16", "endDate(2i)"=>"11", "endDate(1i)"=>"2015"}
 		#		}, 
 		#	"price"=>["", ""], 
 		#	"commit"=>"Create Event", 
 		#	"controller"=>"event", 
 		#	"action"=>"create"
 		#}
        @fail = false
 		@event = Event.new
 		event_params = params[:event]
 		@event.name = event_params[:name]
 		@event.descrition = event_params[:descrition]
 		@event.promoterID = current_user.userID
 		@event.categoryID = params[:category].to_i
 		@event.averageRate=0
 		@event.numRates=0
 		@event.active=true
 		@event.propose=false
        
       	if saveOrDestroy(@event) 
       		return 
       	end
        #@event.save
        
        params[:tags].each do |tag|
            eventTag = EventTags.new
            eventTag.eventID = @event.eventID
            eventTag.tagsID=tag.to_i
            
            #eventTag.save
            if saveOrDestroy(eventTag) 
            	return 
            end
        end
        params[:youtube].each do |link|
            youtube = Youtube.new
            youtube.videoID=link
            youtube.eventID=@event.eventID
            
            if saveOrDestroy(youtube) 
            	return 
            end
            #youtube.save
        end
        params[:spotify].each do |link|
            spotify = Spotify.new
            spotify.playListLink=link
            spotify.eventID=@event.eventID
            
            if saveOrDestroy(spotify) 
            	return 
            end
            #spotify.save
        end
        params[:address].each_with_index do |address, i|
          local = Local.new
          local.address=address
          local.latitude = params[:latitude].index(i)
          local.longitude= params[:longitude].index(i)
          
          if saveOrDestroy(local) 
          	return 
          end
          #local.save
        end

        params[:dates].each_with_index do |date, k|
            eventDate = EventDate.new
            eventDate.startDate = (params[:dates][k.to_s]["startDate(1i)"] << "-" << params[:dates][k.to_s]["startDate(2i)"]<< "-" << params[:dates][k.to_s]["startDate(3i)"])
            eventDate.endDate = (params[:dates][k.to_s]["endDate(1i)"] << "-" << params[:dates][k.to_s]["endDate(2i)"]<< "-" << params[:dates][k.to_s]["endDate(3i)"])
            eventDate.eventID=@event.eventID
            eventDate.preco=params["price"][k].to_f
            #eventDate.localID = date.localID
            eventDate.localID = 999
            
           if saveOrDestroy(eventDate) 
           	return 
           end
            #eventDate.save
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
    	@events = Event.all
 	end

# ========================================================

    def saveOrDestroy(object)
    	begin
        	object.save! # é suposto todos os erros serem verificados em javascript e não dar erro aqui
        	return false
        rescue Exception
        	@fail = true
            flash[:alert] = "Erro ao criar o evento, por favor verifique os dados introduzidos"
            @category = Category.all
            render new_event_path
            return true
        end
    end
end
