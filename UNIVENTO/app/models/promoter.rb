class Promoter < ActiveRecord::Base
    self.table_name = 'Promoter'
    self.primary_key = :promoterID

    has_many :colaborator, :class_name => 'Colaborator', :foreign_key => :promoterID
    has_many :event, :class_name => 'Event', :foreign_key => :promoterID
    belongs_to :user, :class_name => 'User', :foreign_key => :promoterID
end
