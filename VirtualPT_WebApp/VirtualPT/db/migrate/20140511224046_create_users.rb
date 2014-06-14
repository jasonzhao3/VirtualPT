class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	 t.string    :user_id
         t.string 	 :username
         t.string	 :password_digest
         t.string	 :salt
         t.string    :email
      t.timestamps
    end
  end
end
