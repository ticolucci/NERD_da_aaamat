class CreateMembersTasks < ActiveRecord::Migration
  def self.up
    create_table :members_tasks do |t|
      t.integer :member_id
      t.integer :task_id
    end
  end

  def self.down
    drop_table :members_tasks
  end
end