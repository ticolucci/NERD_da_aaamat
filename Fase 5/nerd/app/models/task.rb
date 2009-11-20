class Task < ActiveRecord::Base
  belongs_to :status
  belongs_to :subject

  validates_presence_of :title, :subject
  validates_uniqueness_of :title

  after_save :certificate_status

  def certificate_status
    self.update_attribute :status, Status.find_by_status_type("a_fazer") unless self.status
  end
end