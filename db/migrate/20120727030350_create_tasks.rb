class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :due_date
      t.string :priority
      t.boolean :complete, :default => false
      t.integer :user_id

      t.timestamps
    end
  end
end
