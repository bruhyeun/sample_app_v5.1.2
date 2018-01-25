class CreateDataRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :data_records do |t|
      t.references :data_table, foreign_key: true
      t.text :row

      t.timestamps
    end
  end
end
