require 'spec_helper'

describe "users/show", format: :html do
  
  let(:user) { build(:user) }

  before(:each) do
    assign(:user, user)
    render
  end

  it "should render" do
    rendered.should_not be_blank
  end

  describe "web site rendering" do  
    it "should not show web_site if not present" do
      expect(rendered).to_not include("Web Site")
    end

    it "should include the website if defined" do
      user.web_site = Faker::Internet.domain_name
      render
      expect(rendered).to include("Web Site")
    end
  end

end