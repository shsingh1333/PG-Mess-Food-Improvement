class CreateMealTimingSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_timing_settings do |t|
      t.string :key
      t.time :value

      t.timestamps
    end
  end
end
