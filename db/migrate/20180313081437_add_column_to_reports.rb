class AddColumnToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :chatwork_api_id, :integer
  end
end
