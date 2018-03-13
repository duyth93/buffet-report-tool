class CreateReportDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :report_details do |t|
      t.string :task
      t.string :actual
      t.integer :report_id

      t.timestamps null: false
    end
  end
end
