class Registration < ActiveRecord::Base
    self.table_name = 'Registration'


    belongs_to :event, :class_name => 'Event', :foreign_key => :eventID
    belongs_to :normal, :class_name => 'Normal', :foreign_key => :normalID
end
