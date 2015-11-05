class Normal < ActiveRecord::Base
	self.table_name = "Normal"	
	belongs_to :user, :class_name => 'User', :foreign_key => 'normalID', :validate => true
end
