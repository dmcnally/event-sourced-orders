class AddTotalToOrders < ActiveRecord::Migration[5.1]
  def change
    change_table :orders, id: :uuid, default: nil do |t|
      t.integer :total, null: false
    end
  end
end
