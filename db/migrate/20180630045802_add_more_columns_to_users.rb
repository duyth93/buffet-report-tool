class AddMoreColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :access_token, :text
    add_column :users, :refresh_token, :text
    add_column :users, :expired_at, :datetime
  end
end
