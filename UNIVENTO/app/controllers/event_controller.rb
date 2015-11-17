class EventController < ApplicationController
	def show
    	@event = Event.find(params[:id])
 	end

 	def new
 		@event = Event.new
 		@category = Category.all
 	end
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
 		#	"preco"=>["", ""], 
 		#	"commit"=>"Create Event", 
 		#	"controller"=>"event", 
 		#	"action"=>"create"
 		#}
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

 		@event.save
 		params[:tags].each do |tag|
 			 eventTag = EventTags.new
 			 eventTag.eventID = @event.eventID
 			 eventTag.tagsID=tag.to_i
 			 eventTag.save
 		end
 		params[:youtube].each do |link|
 			youtube = Youtube.new
 			youtube.videoID=link
 			youtube.eventID=@event.eventID
 		end
 		params[:spotify].each do |link|
 			spotify = Youtube.new
 			spotify.playListLink=link
 			spotify.eventID=@event.eventID
 		end
		params[:address].each_with_index do |address, i|
		  local = Local.new
		  local.address=address
		  local.latitude = params[:latitude].index(i)
		  local.longitude= params[:longitude].index(i)
		end
		params[:dates].each do |date|
 			eventDate = EventDate.new
 			eventDate.startDate = date["startDate(3i)"] << "-" << date["startDate(2i)"]<< "-" << date["startDate(1i)"]
 			eventDate.endDate = date["endDate(3i)"] << "-" << date["endDate(2i)"]<< "-" << date["endDate(1i)"]
 			eventDate.eventID=@event.eventID
 			eventDate.preco=date.preco
 			eventDate.localID = date.localID
 		end
 	end
end
