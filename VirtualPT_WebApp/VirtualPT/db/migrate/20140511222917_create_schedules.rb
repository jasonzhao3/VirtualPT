class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	   t.string    	:obj_id
           t.date 	   	:date 
           t.string    	:exercise
           t.integer	:duration
    	   t.integer 	:hold
    	   t.integer 	:reps
    	   t.integer 	:sets
      t.timestamps
    end
  end
end
