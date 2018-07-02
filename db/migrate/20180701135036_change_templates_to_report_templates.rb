class ChangeTemplatesToReportTemplates < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :templates, :report_templates
  end

  def self.down
    rename_table :report_templates, :templates
  end
end
