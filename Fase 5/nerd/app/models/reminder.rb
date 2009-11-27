class Reminder < ActiveRecord::Base

  validates_presence_of :date, :item
  
  after_save :certificate_time
  validate :uniqueness

  belongs_to :item, :polymorphic => true

  def certificate_time
    self.update_attribute(:time, 12) if self.time.nil?
  end

  def uniqueness
    similars = Reminder.find_by_date_and_time_and_item_id_and_item_type(self.date, self.time, self.item_id, self.item_type)
    errors.add :uniqueness, "Esse lembrete já existe no sistema" unless similars.nil?
  end

  def <=> other
    self.date <=> other.date
  end
end