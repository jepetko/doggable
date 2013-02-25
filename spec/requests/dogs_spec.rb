require 'spec_helper'

describe "Dogs Requests" do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in_as_a_valid_user @user

    generate_dogs(@user,5)
  end

  describe "GET /dogs" do

    it "should be success" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dogs_path
      response.status.should be(200)
    end

    it "should return the correct count" do
      get dogs_path
      assert_have_selector ".simple-dog", :count => 5
    end
  end
end
