class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
    	t.string :obj_id
    	t.string :name
    	t.string :instruction
    	t.string :imgURL
    	t.string :videoURL
      t.timestamps
    end
  end
end
