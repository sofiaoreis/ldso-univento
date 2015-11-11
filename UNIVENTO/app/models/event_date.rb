class EventDate < ActiveRecord::Base
	self.table_name = 'EventDate'
    self.primary_key = :dateID

    belongs_to :event, :class_name => 'Event', :foreign_key => :eventID
    belongs_to :local, :class_name => 'Local', :foreign_key => :localID
end
