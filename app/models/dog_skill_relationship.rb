class DogSkillRelationship < ActiveRecord::Base
  attr_accessible :dog_id, :skill_id

  belongs_to :dog
  belongs_to :skill

  validates :dog_id, :presence => true
  validates :skill_id, :presence => true
end