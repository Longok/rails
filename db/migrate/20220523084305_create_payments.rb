class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :address
      t.integer :phone_number
      t.string :type
      t.integer :bill_id
      t.integer :user_id

      t.timestamps
    end
  end
end
