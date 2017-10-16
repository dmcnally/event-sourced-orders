class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: :uuid, default: nil do |t|
      t.jsonb :line_items, null: false
      t.datetime :created_at, null: false
    end
  end
end
