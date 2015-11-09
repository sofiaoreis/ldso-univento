class Youtube < ActiveRecord::Base
	self.table_name = "Youtube"
	self.primary_key = :youtubeID

  	belongs_to :event, :class_name => 'Event', :foreign_key => :eventID, :validate => true
end
