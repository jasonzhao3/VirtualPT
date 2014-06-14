class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.string :obj_id
    	t.string :injury
    	t.string :goal
    	t.string :motivation
      t.timestamps
    end
  end
end
