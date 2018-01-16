class CreateDataLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :data_logs do |t|
      t.references :project, foreign_key: true
      t.references :vessel, foreign_key: true
      t.references :sensor, foreign_key: true
      t.string :source_filename
      t.string :source_folder
      t.string :data_types

      t.timestamps
    end
  end
end
