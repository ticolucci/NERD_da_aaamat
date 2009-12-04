class AtaController < ApplicationController
  def ata
    date = params[:date]
    date =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/
    date = "#{$3}-#{$2}-#{$1}"
    @subjects = Subject.find (:all, :conditions => ["updated_at LIKE ?", "#{date}%"])
    @atendees = Member.find params[:atendees]
    @date = params[:date]
  end

  def new
    @atendees = Member.find :all
  end
end