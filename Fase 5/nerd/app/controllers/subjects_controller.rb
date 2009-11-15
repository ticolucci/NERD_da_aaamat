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
      redirect_to subject_path(@subject.id)
    else
      render :new
    end
  end
end
