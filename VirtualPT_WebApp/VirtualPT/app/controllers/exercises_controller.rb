class ExercisesController < ApplicationController
	def index
		 @exercises = Exercise.parseAll
	end
end
