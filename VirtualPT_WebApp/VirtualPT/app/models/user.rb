class User < ActiveRecord::Base
	include ModelModule
	 # no validations included, but feel free to add your own
  	validates_presence_of :username

  	has_one :profile
  	has_many :schedules


  def self.parseAll
  	return ModelModule.fetchUsers()
  end
  
end