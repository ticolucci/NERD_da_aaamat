class Subject < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title

  has_many :tasks
  has_many :events
  has_many :records

  def content_for_ata
    date = self.updated_at.to_s[0..9]
    tasks = Task.find(:all, :conditions => ["updated_at LIKE ? AND subject_id = ?", "#{date}%", self.id])
    records = Record.find(:all, :conditions => ["updated_at LIKE ? AND subject_id = ?", "#{date}%", self.id])
    events = Event.find(:all, :conditions => ["updated_at LIKE ? AND subject_id = ?", "#{date}%", self.id])
    return tasks + records + events
  end
end
