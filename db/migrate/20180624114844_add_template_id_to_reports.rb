class AddTemplateIdToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :template_id, :integer
  end
end
