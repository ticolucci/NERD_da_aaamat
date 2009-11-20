class SubjectsController < ApplicationController
  
  def index
    store_location
    @subjects = Subject.find :all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new params[:subject]
    if @subject.save
      redirect_to(subject_path(@subject.id))
    else
      render :new
    end
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject.delete
    redirect_to(subjects_path)
  end

  def show
    store_location
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes params[:subject]
      redirect_to(subject_path(@subject.id))
    else
      render :action => 'edit'
    end
  end
end
