require 'spec_helper'

describe Dog do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {
        :name => "Lara",
        :birthday => "01.11.2007"
    }
  end

  it "must not be created if there is no user association" do
    Dog.new(@attr).should_not be_valid
  end

  describe "dogs associations" do

    before(:each) do
      @dog = @user.dogs.create(@attr)
    end

    it "should respond to user association" do
      @dog.should respond_to(:user)
    end
    it "should have a user" do
      @dog.user_id.should == @user.id
      @dog.user.should == @user
    end

  end

end
