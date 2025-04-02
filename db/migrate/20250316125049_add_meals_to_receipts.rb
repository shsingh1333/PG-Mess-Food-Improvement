class AddMealsToReceipts < ActiveRecord::Migration[8.0]
  def change
    add_column :receipts , :total_meal, :integer
    add_column :receipts , :remaining_meal , :integer
  end
end
