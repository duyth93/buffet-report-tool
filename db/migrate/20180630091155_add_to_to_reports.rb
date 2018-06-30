class AddToToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :to_id, :string
  end
end
