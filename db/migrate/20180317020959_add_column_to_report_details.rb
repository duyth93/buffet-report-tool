class AddColumnToReportDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :report_details, :percent, :integer
  end
end
