require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/change_status" do
  fixtures :tasks

  it "should render image from status" do
    assigns[:task] = tasks(:arrumar_deposito)
    render
    response.should have_tag("img[title=?]", 'Feito')
  end
end