class Friendship < ActiveRecord::Base
    self.table_name = 'Friendship'


    belongs_to :normal, :class_name => 'Normal', :foreign_key => :requesterNormalID
    belongs_to :normal, :class_name => 'Normal', :foreign_key => :requestedNormalID
end
