class CreateChatworkApis < ActiveRecord::Migration[5.1]
  def change
    create_table :chatwork_apis do |t|
      t.string :api
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
