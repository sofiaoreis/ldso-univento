class ConviteColaborator < ActiveRecord::Base
	self.table_name = 'ConviteColaborator'
    self.primary_key = "hashID"
    has_one :promoter, :class_name => 'Promoter', :foreign_key => :promoterID

end
