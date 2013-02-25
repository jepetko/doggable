require 'spec_helper'

describe DogSkillRelationship do

  before(:each) do
    @usr = FactoryGirl.create(:user)
    @dog = FactoryGirl.create(:dog, :user_id => @usr.id)


    @skill = FactoryGirl.create(:skills)

    @relationship = @dog.dog_skill_relationships.build( :skill_id => @skill.id )
  end

  it "should save the relationship between the dog and the skills" do
    @relationship.save!
  end

  describe "relationship's associations to dogs and skills" do

    before(:each) do
      @relationship.save
    end

    it "should respond to dog_id" do
      @relationship.should respond_to(:dog_id)
    end

    it "should respond to skill_id" do
      @relationship.should respond_to(:skill_id)
    end
  end
end
