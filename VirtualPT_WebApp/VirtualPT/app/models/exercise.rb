class Exercise < ActiveRecord::Base
	include ModelModule

	has_and_belongs_to_many :schedules


	def self.parseAll
		return ModelModule.fetchObjects('Exercise')
	end
end
