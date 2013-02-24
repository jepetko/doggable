require 'spec_helper'

describe Skill do

  before(:each) do
    @attr = { :name => "barking" }
    @attr_empty = {:name => ""}
  end

  it "should be valid when :name is given" do
    Skill.new(@attr).should be_valid
  end

  it "should not be valid with blank :name" do
    Skill.new(@attr_empty).should_not be_valid
  end

  it "should be stored in the skills table" do
    skill = Skill.new(@attr)
    skill.save!
  end

end
