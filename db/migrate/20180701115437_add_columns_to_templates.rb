class AddColumnsToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :user_id, :integer
  end
end
