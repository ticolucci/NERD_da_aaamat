class EventsController < ApplicationController
  def show
    @event = Event.find params[:id]
    @subject = Subject.find params[:subject_id]
  end

  def new
    @event = Event.new
    @subject = Subject.find params[:subject_id]
  end

  def create
    @subject = Subject.find params[:subject_id]
    @event = Event.new params[:event]
    if @event.save
      redirect_to(subject_path(params[:subject_id]))
    else
      render :action => :new
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to subject_path(params[:subject_id])
  end

  def edit
    @event = Event.find params[:id]
    @subject = Subject.find params[:subject_id]
  end

  def update
    @event = Event.find params[:id]
    @subject = Subject.find params[:subject_id]
    if @event.update_attributes params[:event]
      redirect_to subject_event_path(@subject.id, @event.id)
    else
      render :action => :edit
    end
  end
end