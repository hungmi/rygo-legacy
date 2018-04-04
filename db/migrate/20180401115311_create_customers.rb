class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :code
      t.string :name
      t.string :address
      t.string :phone
      t.string :company_name
      t.decimal :discount, precision: 4, scale: 3, default: 1

      t.timestamps
    end
  end
end
