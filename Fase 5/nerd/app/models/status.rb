class Status < ActiveRecord::Base
  has_many :tasks

  def self.next status
    case status.status_type
    when "a_fazer"
      return Status.find_by_status_type "fazendo"
    when "fazendo"
      return Status.find_by_status_type "feito"
    when "feito"
      return Status.find_by_status_type "a_fazer"
    end
  end
end