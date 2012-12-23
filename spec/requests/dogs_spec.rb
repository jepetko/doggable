require 'spec_helper'

describe "Dogs Requests" do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in_as_a_valid_user @user
  end

  describe "GET /dogs" do
    it "should be success" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dogs_path
      response.status.should be(200)
    end
  end
end
