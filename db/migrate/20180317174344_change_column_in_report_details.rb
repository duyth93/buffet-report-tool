class ChangeColumnInReportDetails < ActiveRecord::Migration[5.1]
  def change
    change_column :report_details, :actual, :text
  end
end
