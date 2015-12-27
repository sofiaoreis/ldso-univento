class Tags < ActiveRecord::Base
    self.table_name = 'Tags'
    self.primary_key = :tagsID

    has_many :categorytags, :class_name => 'CategoryTags', :foreign_key => :tagsID
    has_many :eventtags, :class_name => 'EventTags', :foreign_key => :tagsID
    has_many :category, :through => :categorytags
end
