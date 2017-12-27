class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false, unique: true
      t.string :alias
      t.string :address1
      t.string :address2
      t.string :city
      t.string :post_code
      t.string :country
      t.string :email
      t.string :contact_number

      t.timestamps
    end
  end
end
