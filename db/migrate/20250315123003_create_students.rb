class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :contact_no
      t.string :aadhar_card_no
      t.date :date_of_occupy
      t.integer :room_no

      t.timestamps
    end
  end
end
