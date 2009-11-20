class TasksController < ApplicationController
  def show
    @task = Task.find params[:id]
    @subject = Subject.find params[:subject_id]
  end
end