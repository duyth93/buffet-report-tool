class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.text :problems
      t.text :next_day_plan
      t.text :free_comment
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
