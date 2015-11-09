class Local < ActiveRecord::Base
	self.table_name = "Local"
	self.primary_key = :localID
	
	has_many :date, :class_name => 'Date', :foreign_key => :localID
end
