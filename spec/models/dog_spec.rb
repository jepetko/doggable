require 'spec_helper'

describe Dog do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @dog_attr = {
        :name => "Lara",
        :birthday => "01.11.2007",
        :sex => "f"
    }

    @skill_attr = {
        :name => "biting"
    }

    @many_skill_attr = [ {:name => "running"},{:name => "jumping"},{:name => "playing balls"} ]
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

  describe "mass assignment of skill ids" do
    before(:each) do
      @many_skill_attr.each do |attr|
        Skill.new(attr).save!
      end
      @all_skills_but_last = []
      @all_skills = Skill.all
      @all_skills.each_with_index do |skill,idx|
        break if(idx==@all_skills.length-1)
        @all_skills_but_last << skill
      end
      @last_skill = @all_skills.last
    end

    it "should be possible to pass the skills" do
        ids = []
        @all_skills_but_last.each_with_index do |skill,idx|
          ids << skill.id
        end
        attr = @dog_attr.merge( :skill_ids => ids )
        @user.dogs.build( attr )
        @user.save!

        dog = @user.dogs.last
        dog.skills.should_not be_empty
        dog.skills.length.should == ids.length
        @all_skills_but_last.each do |skill|
          dog.skills.should include(skill)
        end

        #add the last skill by using update_attributes
        skill_ids = dog.skill_ids
        skill_ids << @last_skill.id
        dog.update_attributes({:skill_ids => skill_ids})
        dog.skills.length.should == @all_skills.length
    end

  end

end
