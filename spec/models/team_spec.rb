require 'spec_helper'

describe Team do
  it { should have_many(:users) }
  it { should validate_presence_of :name }
  
  it "should use name asc as the default sort ordering" do
    expect(Team.scoped).to eq(Team.order('name ASC'))  
  end
  
end
