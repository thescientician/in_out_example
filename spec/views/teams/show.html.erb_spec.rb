require 'spec_helper'

describe "teams/show" do
  let(:current_user) { stub_model(User) }

  before(:each) do

    view.stub(current_user:current_user)
    @team = assign(:team, stub_model(Team,
      :name => "An Awesome Name"
    ))
    @users = assign(:users, [stub_model(User)])
  end

  it "should render" do
    render
    rendered.should_not be_blank
  end

  it "should show the current user if the user belongs to the team" do
    render
    rendered.should_not include("My Status")
    current_user.team = @team
    render
    rendered.should include("My Status")
  end

  it "should render each user name" do
    render
    rendered.should include("An Awesome Name")
  end


end
