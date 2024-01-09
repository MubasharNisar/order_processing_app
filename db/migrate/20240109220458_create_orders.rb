class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.integer :order_type
      t.integer :status

      t.timestamps
    end
  end
end
