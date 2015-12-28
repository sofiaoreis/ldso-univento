class ConviteColaborator < ActiveRecord::Base
	self.table_name = 'ConviteColaborator'
    self.primary_key = "hashID"
    has_one :promoter, :class_name => 'Promoter', :foreign_key => :promoterID

    def self.accept(hashID,email)
    	convite = ConviteColaborator.find_by_hashID(hashID)
    	puts "===================================="
		puts convite.inspect   
		puts "===================================="
    	if convite.present?
    		if convite.email == email
    			user = User.where(email: email).take
    			if user.present?
	    			normal = Normal.find_by_normalID(user.userID)
	    			if normal.present?
	    				colaborator = Colaborator.new
	    				colaborator.normalID = normal.normalID
    					colaborator.promoterID = convite.promoterID
    					if colaborator.save
    						convite.destroy
    						return true
    					end
	    			end
			    end
    		end
    	end	
    	return false
    end
end
