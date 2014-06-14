class SchedulesController < ApplicationController
  require 'Date'
  
  def index	
	@users = User.parseAll
	@exercises = Exercise.parseAll
	@schedule = Schedule.new



	# @results = createObject('Yaoy2aoObject', {
 #      "foo2" => "bar"
 #    })

	# @user = createUser({
	# 	"username" => "gw2en",
	# 	"password" => "123",
	# 	"email" => "gwen@stanfor2d.edu",
	# 	"profile" => nil
	# 	# "profile" => {
 # 	# 					 "__type" => "Pointer",
 # 	# 					 # "className" => "Profile",
 #  # 						#  "objectId" => "null"
	# 	# 			  }
	# 	})
	# profile_query = Parse::Query.new("Profile")
	# profile_query.get

	# puts profile_query
  end


  def new
    @users = User.parseAll
    @exercises = Exercise.parseAll
    @schedule = Schedule.new
  end

  def schedule
    date = params[:schedule][:date].split('/')
    date_str = DateTime.new(date[2].to_i, date[0].to_i, date[1].to_i)
  	
    success, message = createObject("Schedule", {
  		"date" => {
                "__type" => "Date",
                "iso" => date_str
                },
  		"user" => {
  					"__type" => "Pointer",  
  					"className" => "_User",
  					"objectId" => params[:schedule][:username]
  				  },
  		"exercise" => {
  					"__type" => "Pointer",
  					"className" => "Exercise",
  					"objectId" => params[:schedule][:exercise]
  				  },
      "reps" => params[:schedule][:reps].to_i,
      "duration" => params[:schedule][:duration].to_i,
      "hold" => params[:schedule][:hold].to_i,
      "sets" => params[:schedule][:sets].to_i
  		})
    
     if (success) 
      flash[:notice] = "New exercise successfully added to schedule! " + message
    else
      flash[:notice] = message  
    end
    redirect_to new_schedule_path
  end


  private
  def schedule_params
  	params.permit(:username, :date, :exercise, :reps, :duration, :hold, :sets)
  end

end
