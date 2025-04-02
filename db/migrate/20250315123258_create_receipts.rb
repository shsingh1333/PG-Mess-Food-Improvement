class CreateReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :receipts do |t|
      t.date :receipt_date
      t.string :for_month
      t.integer :advance
      t.boolean :mess
      t.integer :room_rent
      t.integer :total
      t.boolean :payment_done
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
