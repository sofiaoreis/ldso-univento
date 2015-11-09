class Image < ActiveRecord::Base
	self.table_name = "Image"
	self.primary_key = :imageID

	belongs_to :event, :class_name => 'Event', :foreign_key => :eventID, :validate => true
end
