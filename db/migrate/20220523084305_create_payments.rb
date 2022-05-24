class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :address
      t.integer :phone_number
      t.string :payment_type
      t.integer :bill_id
      t.integer :user_id

      t.timestamps
    end
  end
end
