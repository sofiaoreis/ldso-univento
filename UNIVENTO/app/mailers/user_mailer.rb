class UserMailer < ApplicationMailer
	def convite_email(email, promoter, url, convite)
		@promoter = promoter
		@url = url
		@email = email
		@msg = convite
	    mail(:to => email, :subject => "Convite para colaborador de "+promoter)
	end
end
