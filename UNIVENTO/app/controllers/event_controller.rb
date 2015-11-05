class EventController < ApplicationController
	def show
    	@event = Event.find(params[:id])
 	end
end
