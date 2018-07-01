class ChangeColumnNameOfReports < ActiveRecord::Migration[5.1]
  def change
    rename_column :reports, :template_id, :report_template_id
  end
end
