class CreateDataTables < ActiveRecord::Migration[5.1]
  def change
    create_table :data_tables do |t|
      t.references :project, foreign_key: true
      t.string :source_filename
      t.string :source_folder
      t.string :data_types
      t.string :header
      t.text :data

      t.timestamps
    end
  end
end
