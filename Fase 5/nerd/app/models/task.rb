class Task < ActiveRecord::Base
  belongs_to :status
  belongs_to :subject

  has_many :members_tasks
  has_many :members, :through => :members_tasks
  has_many :reminders, :as => :item

  validates_presence_of :title, :subject
  validates_uniqueness_of :title

  after_save :certificate_status, :updates_subject

  def updates_subject
    self.subject.update_attribute :updated_at, self.updated_at
  end

  def certificate_status
    self.update_attribute :status, Status.find_by_status_type("a_fazer") unless self.status
  end

  def save_members members
    unless members.nil?
      members.each do |member|
        MembersTask.create! :task => self, :member_id => member
      end
    end
  end

  def update_members members
    if members.nil?
      self.members.each do |member|
        MembersTask.find_by_member_id_and_task_id(member, self.id).delete
      end
    else
      current_members = self.members.collect {|m| m.id}
      members.each do |member|
        unless current_members.include? member
          MembersTask.create! :task => self, :member_id => member
        end
        current_members.delete member
      end
      current_members.each do |member|
        MembersTask.find_by_member_id_and_task_id(member, self.id).delete
      end
    end
  end
end