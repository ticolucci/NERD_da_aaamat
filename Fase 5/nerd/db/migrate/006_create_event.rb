class CreateEvent < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :body
      t.time :time
      t.date :date
      t.belongs_to :subject

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end