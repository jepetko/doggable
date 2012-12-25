require 'spec_helper'

describe UsersController do

  render_views

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @dog = FactoryGirl.build(:dog, :user => @user)
    @dog.save!
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
      response.should have_selector( "p", :content => @user.name )
      response.should have_selector( "p", :content => @user.email )

      response.should have_selector( "div.well" )
    end
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end
    
  end

end
