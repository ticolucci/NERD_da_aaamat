class Reminder < ActiveRecord::Base

  validates_presence_of :date, :item_id
  
  after_save :certificate_time
  validate :uniqueness

  def certificate_time
    self.update_attribute(:time, "12:00:00") if self.time.empty?
  end

  def uniqueness
    similars = Reminder.find_by_date_and_time_and_item_id_and_item_type(self.date, self.time, self.item_id, self.item_type)
    errors.add :uniqueness, "Esse lembrete já existe no sistema" unless similars.nil?
  end

end