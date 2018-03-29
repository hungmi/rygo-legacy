class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :cloth
      t.integer :amount, null: false
      t.date :deliver_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
