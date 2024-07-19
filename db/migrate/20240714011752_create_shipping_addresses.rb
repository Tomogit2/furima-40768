class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :zip_code
      t.integer :prefecture_id
      t.string :municipalities
      t.string :street_address
      t.string :building_name
      t.string :telephone_number
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
