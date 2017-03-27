require 'spec_helper'

describe "users/index", format: :html do
  
  let(:signed_in_user) { create(:user) }

  before(:each) do
    view.stub(current_user:signed_in_user)
    assign(:users, [ create(:user) ] )
    assign(:teams, [ create(:team) ] )
  end

  it "should render" do
    
    render
    rendered.should_not be_blank
  end

end