class AddEmailToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :email, :string 
    add_index :students, :email, unique: true
  end
end
