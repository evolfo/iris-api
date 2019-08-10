class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :billing_address
      t.string :fan_level
      t.string :tier

      t.timestamps
    end
  end
end
