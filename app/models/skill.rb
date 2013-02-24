class Skill < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :length => { :maximum => 50 }

  has_many :dog_skill_relationships
  has_many :dogs, :through => :dog_skill_relationships
end
