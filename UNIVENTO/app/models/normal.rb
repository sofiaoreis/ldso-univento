class Normal < ActiveRecord::Base
    self.table_name = 'Normal'
    self.primary_key = :normalID
    
    mount_uploader :photo, ImageUploader

    has_many :colaborator, :class_name => 'Colaborator', :foreign_key => :normalID
    belongs_to :user, :class_name => 'User', :foreign_key => :normalID
    #has_many :rate, :class_name => 'Rate', :foreign_key => :normalID
    has_many :registration, :class_name => 'Registration', :foreign_key => :normalID

    has_many :normal_category, :class_name => 'NormalCategory', :foreign_key => :normalID
    has_many :normal_tags, :class_name => 'NormalTags', :foreign_key => :normalID

end
