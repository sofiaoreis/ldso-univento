class Event < ActiveRecord::Base
    self.table_name = 'Event'
    self.primary_key = :eventID

    validates_length_of :name,
               :minimum => 1,           # more than 8 characters
               :maximum => 50,          # shorter than 16 characters
               :too_short => 'Inserir nome do evento',  
               :too_long => 'Nome demasiado grande'

    validates_length_of :descrition,
               :minimum => 20,           # more than 8 characters
               :too_short => 'Descrição demasiado pequena'    

    validates_numericality_of :preco, :allow_nil => true, :message => 'Não é um número'

    has_many :eventdate, :class_name => 'EventDate', :foreign_key => :eventID
    belongs_to :category, :class_name => 'Category', :foreign_key => :categoryID
    belongs_to :promoter, :class_name => 'Promoter', :foreign_key => :promoterID
    has_many :eventtags, :class_name => 'EventTags', :foreign_key => :eventID
    has_many :image, :class_name => 'Image', :foreign_key => :eventID
    accepts_nested_attributes_for :image
    has_many :rate, :class_name => 'Rate', :foreign_key => :eventID
    has_many :registration, :class_name => 'Registration', :foreign_key => :eventID
    has_many :spotify, :class_name => 'Spotify', :foreign_key => :eventID
    has_many :youtube, :class_name => 'Youtube', :foreign_key => :eventID

    has_many :tags, :through => :eventtags
end


=begin
    
CREATE TABLE Event
(
    descrition TEXT NULL,
    name VARCHAR(50) NULL,
    propose BOOL NULL,
    averageRate DOUBLE NULL,
    numRates int NULL,
    activeDate DATETIME NULL,
    docsID VARCHAR(50) NULL,
    eventID INTEGER NOT NULL AUTO_INCREMENT,
    categoryID INTEGER NULL,
    promoterID INTEGER NULL,
    preco DOUBLE NULL,
    PRIMARY KEY (eventID),
    KEY (categoryID),
    KEY (promoterID)

) ;
    
=end