class NormalCategory < ActiveRecord::Base
    self.table_name = 'NormalCategory'


    belongs_to :normal, :class_name => 'Normal', :foreign_key => :normalID
    belongs_to :category, :class_name => 'Category', :foreign_key => :categoryID
end