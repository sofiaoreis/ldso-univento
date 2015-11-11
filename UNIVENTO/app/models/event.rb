class Event < ActiveRecord::Base
    self.table_name = 'Event'
    self.primary_key = :eventID

    has_many :eventdate, :class_name => 'EventDate', :foreign_key => :eventID
    belongs_to :category, :class_name => 'Category', :foreign_key => :categoryID
    belongs_to :promoter, :class_name => 'Promoter', :foreign_key => :promoterID
    has_many :eventtags, :class_name => 'EventTags', :foreign_key => :eventID
    has_many :image, :class_name => 'Image', :foreign_key => :eventID
    has_many :rate, :class_name => 'Rate', :foreign_key => :eventID
    has_many :registration, :class_name => 'Registration', :foreign_key => :eventID
    has_many :spotify, :class_name => 'Spotify', :foreign_key => :eventID
    has_many :youtube, :class_name => 'Youtube', :foreign_key => :eventID

    has_many :tags, :through => :eventtags
end
