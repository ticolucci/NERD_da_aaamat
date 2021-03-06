class TasksController < ApplicationController
  def show
    @task = Task.find params[:id]
    @subject = Subject.find params[:subject_id]
    @members = @task.members.sort
    @reminders = @task.reminders.sort
  end

  def new
    @task = Task.new
    @subject = Subject.find params[:subject_id]
    @members = Member.find :all
    @task_members = @task.members
  end

  def create
    params[:task][:due_date] = params[:task][:due_date].gsub "/", "-"
    @subject = Subject.find params[:subject_id]
    @task = Task.new params[:task]
    if @task.save
      @task.save_members params[:members_ids]
      redirect_to(subject_path(params[:subject_id]))
    else
      render :action => :new
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    redirect_to subject_path(params[:subject_id])
  end

  def edit
    @task = Task.find params[:id]
    @subject = Subject.find params[:subject_id]
    @members = Member.find :all
    @task_members = @task.members
  end

  def update
    @task = Task.find params[:id]
    @subject = Subject.find params[:subject_id]
    if @task.update_attributes params[:task]
      @task.update_members params[:members_ids]
      redirect_to subject_task_path(@subject.id, @task.id)
    else
      render :action => :edit
    end
  end

  def change_status
    @task = Task.find params[:id]
    @task.update_attribute :status, Status.next(@task.status)
    render :change_status, :layout => false
  end
end