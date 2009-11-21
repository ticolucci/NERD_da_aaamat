class Member < ActiveRecord::Base
  has_many :members_tasks
  has_many :tasks, :through => :members_tasks

  def <=> other
   self.name <=> other.name
  end
end
