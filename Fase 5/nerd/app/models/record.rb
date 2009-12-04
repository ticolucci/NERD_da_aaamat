class Record < ActiveRecord::Base
  belongs_to :subject

  validates_presence_of :title, :subject
  validates_uniqueness_of :title

  after_save :updates_subject

  def updates_subject
    self.subject.update_attribute :updated_at, self.updated_at
  end
end