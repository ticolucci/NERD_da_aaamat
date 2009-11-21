require 'spec_helper'

describe Status do
  fixtures :statuses
  it "should know how to go to next status" do
    todo = statuses(:a_fazer)
    doing = statuses(:fazendo)
    done = statuses(:feito)
    Status.next(todo).should == doing
    Status.next(doing).should == done
    Status.next(done).should == todo
  end
end