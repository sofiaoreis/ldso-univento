class Rate < ActiveRecord::Base
    self.table_name = 'Rate'
    self.primary_key = :rateID

    belongs_to :event, :class_name => 'Event', :foreign_key => :eventID
    belongs_to :normal, :class_name => 'Normal', :foreign_key => :normalID
end
