class CreateStatus < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :status_type
    end
  end

  def self.down
    drop_table :statuses
  end
end