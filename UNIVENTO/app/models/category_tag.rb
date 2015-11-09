class CategoryTags < ActiveRecord::Base
    self.table_name = 'CategoryTags'


    belongs_to :category, :class_name => 'Category', :foreign_key => :categoryID
    belongs_to :tags, :class_name => 'Tags', :foreign_key => :tagsID
end
