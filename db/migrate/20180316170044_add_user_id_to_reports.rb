class AddUserIdToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :user_id, :integer
  end
end
