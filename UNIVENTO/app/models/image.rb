class Image < ActiveRecord::Base
	self.table_name = "Image"
	self.primary_key = :imageID
	mount_uploader :image, ImageUploader
	belongs_to :event, :class_name => 'Event', :foreign_key => :eventID, :validate => true
end
