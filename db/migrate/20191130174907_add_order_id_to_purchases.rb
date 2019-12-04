class AddOrderIdToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :order_id, :string
  end
end
