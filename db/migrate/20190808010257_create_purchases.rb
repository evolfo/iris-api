class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :amount
      t.string :bundle_name
      t.integer :user_id
      t.timestamps
    end
  end
end
