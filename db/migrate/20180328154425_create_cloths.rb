class CreateCloths < ActiveRecord::Migration[5.2]
  def change
    create_table :cloths do |t|
      t.string :code, null: false
      t.string :jancode
      t.string :brand
      t.belongs_to :supplier, index: true
      t.decimal :price, precision: 10, scale: 0

      t.timestamps
    end
  end
end
