class Event < ActiveRecord::Base
	self.table_name = "Event"
	has_many :youtube, :foreign_key => 'eventID'
end
