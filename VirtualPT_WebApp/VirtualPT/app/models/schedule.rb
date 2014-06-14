class Schedule < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :exercises
	
	def username
		@username
	end

	def username=(username)
		@username = username
	end
end


