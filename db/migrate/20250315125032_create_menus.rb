class CreateMenus < ActiveRecord::Migration[8.0]
  def change
    create_table :menus do |t|
      t.date :date
      t.text :breakfast
      t.text :lunch
      t.text :dinner

      t.timestamps
    end
  end
end
