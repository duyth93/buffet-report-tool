class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.text :content
      t.boolean :is_default
    end
  end
end
