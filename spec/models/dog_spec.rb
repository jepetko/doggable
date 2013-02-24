require 'spec_helper'

describe Dog do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @dog_attr = {
        :name => "Lara",
        :birthday => "01.11.2007"
    }

    @skill_attr = {
        :name => "biting"
    }
  end

  it "must not be created if there is no user association" do
    Dog.new(@dog_attr).should_not be_valid
  end

  describe "dogs validations" do

    before(:each) do
      @dog = @user.dogs.create(@dog_attr)
    end

    it "should require a valid name" do
      @dog.name.should_not be_blank
    end

    it "should respond to user association" do
      @dog.should respond_to(:user)
    end
  end

  describe "dog's user associations" do

    before(:each) do
      @dog = @user.dogs.create(@dog_attr)
    end

    it "should have a user" do
      @dog.user_id.should == @user.id
      @dog.user.should == @user
    end

    it "should respond to skills relationships" do
      @dog.should respond_to(:dog_skill_relationships)
      @dog.should respond_to(:skills)
    end
  end

  describe "dog's skills associations" do

    before(:each) do
      @dog = @user.dogs.create(@dog_attr)

      @skill = Skill.new(@skill_attr)
      @skill.save!
    end

    it "should be able to store relationships to skills" do
      @dog.dog_skill_relationships.create!(:skill_id => @skill.id)
      @dog.skills.should include(@skill)
    end

  end

end
