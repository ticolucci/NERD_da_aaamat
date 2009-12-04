require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ata/ata" do
  fixtures :subjects

  before :each do
    assigns[:subjects] = @subjects = [subjects(:bife), subjects(:copa_usp)]
    assigns[:atendees] = @atendees = Member.find(:all)
    assigns[:date] = @date = "20/12/2009"
    render :layout => "application"
  end

  it "should have a title" do
    response.should have_tag("h1", "Ata #{@date}")
  end

  it "should have its atendees" do
    response.should have_tag("h3", "Presentes:")
    response.should have_tag("p", /João,.* Lucianna,.* Thiago/m)
  end

  it "should show a list of subjects" do
    response.should have_tag("h3", "Pauta:")
    response.should have_tag("ul#list") do
      with_tag("li") do
        with_tag("a", "BIFE")
      end
    end
  end

  it "should show a list of subjects" do
    response.should have_tag("h3", "BIFE")
    response.should have_tag("ul#subject_content") do
      with_tag("li", /Falar com Diretor:/m)
    end
  end

  it "should have a link to subjects list" do
    response.should have_tag("a[href=?]", subjects_path)
  end

end