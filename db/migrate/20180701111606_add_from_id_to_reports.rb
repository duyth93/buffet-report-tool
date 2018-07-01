class AddFromIdToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :from_id, :string
  end
end
