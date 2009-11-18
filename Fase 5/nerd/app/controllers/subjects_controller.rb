class SubjectsController < ApplicationController
  def index
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
    @subject = Subject.find params[:id]
  end

  def edit
    @subject = Subject.find params[:id]
  end
end
