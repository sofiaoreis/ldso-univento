class Spotify < ActiveRecord::Base
    self.table_name = 'Spotify'
    self.primary_key = :spotifyID

    belongs_to :event, :class_name => 'Event', :foreign_key => :eventID
end
