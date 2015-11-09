class Category < ActiveRecord::Base
    self.table_name = 'Category'
    self.primary_key = :categoryID

    has_many :categorytags, :class_name => 'CategoryTags', :foreign_key => :categoryID
    has_many :event, :class_name => 'Event', :foreign_key => :categoryID
end
