class EventController < ApplicationController

# ========================================================

	def show
    	@event = Event.find(params[:id])
    	#render plain: @event.eventtags.tags.inspect
    	#@event.eventtags.to_ary().each
 	end

# ========================================================

	def index
    	@events = Event.all
 	end

# ========================================================

end