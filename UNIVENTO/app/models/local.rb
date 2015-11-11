class Local < ActiveRecord::Base
	self.table_name = "Local"
	self.primary_key = :localID
	
	has_many :eventdate, :class_name => 'EventDate', :foreign_key => :localID
end
