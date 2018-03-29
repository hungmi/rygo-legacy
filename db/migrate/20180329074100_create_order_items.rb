class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :cloth
      t.integer :amount, null: false
      t.integer :deliver_month
      t.integer :deliver_period, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
