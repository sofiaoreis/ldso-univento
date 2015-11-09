class Colaborator < ActiveRecord::Base
    self.table_name = 'Colaborator'


    belongs_to :normal, :class_name => 'Normal', :foreign_key => :normalID
    belongs_to :promoter, :class_name => 'Promoter', :foreign_key => :promoterID
end
