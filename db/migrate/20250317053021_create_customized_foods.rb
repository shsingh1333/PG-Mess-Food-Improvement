class CreateCustomizedFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :customized_foods do |t|
      t.string :name
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
