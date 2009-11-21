class TasksController < ApplicationController
  def show
    @task = Task.find params[:id]
    @subject = Subject.find params[:subject_id]
  end

  def new
    @task = Task.new
    @subject = Subject.find params[:subject_id]
  end

  def create
    params[:task][:due_date] = params[:task][:due_date].gsub "/", "-"
    @subject = Subject.find params[:subject_id]
    @task = Task.new params[:task]
    if @task.save
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

  def change_status
    @task = Task.find params[:id]
    @task.update_attribute :status, Status.next(@task.status)
    render :change_status, :layout => false
  end
end