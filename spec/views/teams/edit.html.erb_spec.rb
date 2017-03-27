require 'spec_helper'

describe "teams/edit" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :name => "MyString"
    ))
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", team_path(@team), "post" do
      assert_select "input#team_name[name=?]", "team[name]"
    end
  end
end
