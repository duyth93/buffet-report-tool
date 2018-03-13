class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :chatwork_room_id

      t.timestamps null: false
    end
  end
end
