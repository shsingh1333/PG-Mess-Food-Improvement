class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :customized_food, null: false, foreign_key: true
      t.integer :quantity, :default=>1

      t.timestamps
    end
  end
end
