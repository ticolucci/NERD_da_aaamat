class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :title
      t.string :body
      t.date :due_date
      t.belongs_to :status

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end