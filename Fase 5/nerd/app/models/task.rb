class Task < ActiveRecord::Base
  belongs_to :status
  validates_presence_of :title
  validates_uniqueness_of :title
  after_save :certificate_status

  def certificate_status
    self.update_attribute :status, Status.find_by_status_type("A Fazer") unless self.status
  end
end