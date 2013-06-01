class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :category_id
      t.string :title
      t.text :description
      t.string :budget
      t.date :start_date
      t.date :end_date
      t.integer :status

      t.timestamps
    end
  end
end
