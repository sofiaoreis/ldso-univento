class NormalTags < ActiveRecord::Base
    self.table_name = 'NormalTags'


    belongs_to :normal, :class_name => 'Normal', :foreign_key => :normalID
    belongs_to :tags, :class_name => 'Tags', :foreign_key => :tagsID
end