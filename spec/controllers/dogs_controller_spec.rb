require 'spec_helper'

describe DogsController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @dog = FactoryGirl.build(:dog, user: @user)
    @dog.save!
  end

  describe "GET 'show'" do

    it "should be successful" do
      get :show, :id => @dog.id
      response.should be_success
    end

  end

end
