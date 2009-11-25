class Event < ActiveRecord::Base
  belongs_to :subject

  validates_presence_of :title, :subject
  validates_uniqueness_of :title

end