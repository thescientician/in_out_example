require 'spec_helper'

describe ApplicationHelper do

  let(:user) { FactoryGirl.create(:user) }

  describe "name_with_status" do
    it "should build at all" do
      name_with_status(user.full_name, user).should_not be_blank
    end

    it "should contain a p tag wrapping a link and a span" do
      result = name_with_status(user.full_name, user)
      result.should include('<p>')
      result.should include('<a')
      result.should include('<span')
    end

    it "should generate a link with a data-url" do
      result = name_with_status(user.full_name, user)
      result.should include('data-url="/users/1/status"')
    end

    it "should generate a link with data-current-user if set" do
      result = name_with_status(user.full_name, user, true)
      result.should include('data-current-user="true"')
    end

  end
end