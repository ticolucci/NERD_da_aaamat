class RecordsController < ApplicationController
  def show
    @record = Record.find params[:id]
    @subject = Subject.find params[:subject_id]
  end

  def new
    @record = Record.new
    @subject = Subject.find params[:subject_id]
  end

  def create
    @subject = Subject.find params[:subject_id]
    @record = Record.new params[:record]
    if @record.save
      redirect_to(subject_path(params[:subject_id]))
    else
      render :action => :new
    end
  end

  def destroy
    @record = Record.find params[:id]
    @record.destroy
    redirect_to subject_path(params[:subject_id])
  end

  def edit
    @record = Record.find params[:id]
    @subject = Subject.find params[:subject_id]
  end

  def update
    @record = Record.find params[:id]
    @subject = Subject.find params[:subject_id]
    if @record.update_attributes params[:record]
      redirect_to subject_record_path(@subject.id, @record.id)
    else
      render :action => :edit
    end
  end
end