require 'spec_helper'

describe "users/edit", format: :html do
  
  let(:user) { build(:user) }

  before(:each) do
    assign(:user, user)
    render
  end

  it "should render" do
    rendered.should_not be_blank
  end

  it "should include a field for selecting team" do
    rendered.should include('select id="user_team_id"')
  end

end