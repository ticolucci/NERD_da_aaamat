class RemindersController < ApplicationController

  def new
    @reminder = Reminder.new
    case params[:item_type].downcase
    when 'task'
      @item = Task.find params[:item_id]
    when 'event'
      @item = Event.find params[:item_id]
    end
    render :new, :layout => false
  end

  def create
    params[:reminder][:date] = params[:reminder][:date].gsub "/", "-"
    @reminder = Reminder.new params[:reminder]
    if @reminder.save
      redirect_to subject_task_path(@reminder.item.subject.id, @reminder.item.id)
    else
      render :action => :new
    end
  end

  def destroy
    @reminder = Reminder.find params[:id]
    @reminder.destroy
  end
end