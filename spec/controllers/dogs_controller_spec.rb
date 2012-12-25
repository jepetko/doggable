require 'spec_helper'

describe DogsController do

  render_views

  before (:each) do
    ##### create a user and sign-in!
    @user = FactoryGirl.create(:user)
    sign_in @user

    ##### create a dog for this user!
    @dog = FactoryGirl.build(:dog, user: @user)
    @dog.save!
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
      response.should have_selector("table", :content => @dog.name )
    end
  end

end
