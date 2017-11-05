class AddTotalToOrders < ActiveRecord::Migration[5.1]
  def change
    execute "delete from orders"

    change_table :orders, id: :uuid, default: nil do |t|
      t.integer :total, null: false
    end
  end
end
