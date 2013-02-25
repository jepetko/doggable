require 'spec_helper'

describe SkillsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @dog = FactoryGirl.build(:dog, :user => @user)
    @dog.save!
  end

end
