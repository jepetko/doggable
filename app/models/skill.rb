class Skill < ActiveRecord::Base
  attr_accessible :name, :picture

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_attachment :picture, :size => { :in => 0..10.kilobytes }

  has_many :dog_skill_relationships
  has_many :dogs, :through => :dog_skill_relationships

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/:style/missing.png"
end
