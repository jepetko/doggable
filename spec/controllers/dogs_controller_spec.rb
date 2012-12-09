require 'spec_helper'

describe DogsController do

  before (:each) do
    ##### create a user and sign-in!
    @user = FactoryGirl.create(:user)
    sign_in @user

    ##### create a dog for this user!
    @dog = FactoryGirl.build(:dog, user: @user)
    @dog.save!
  end

  describe "GET 'index'" do
    get :index
    response.should be_success
    response.should have_selector('table')
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @dog.id
      response.should be_success
    end
  end

end
