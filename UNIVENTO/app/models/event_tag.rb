class EventTags < ActiveRecord::Base
    self.table_name = 'EventTags'


    belongs_to :event, :class_name => 'Event', :foreign_key => :eventID
    belongs_to :tags, :class_name => 'Tags', :foreign_key => :tagsID
end
