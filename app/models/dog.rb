class Dog < ActiveRecord::Base
  include DogsHelper
  attr_accessible :birthday, :name, :skill_ids
  validates :user_id, :presence => true
  validates :name, :presence => true

  belongs_to :user

  has_many :dog_skill_relationships, :foreign_key => :dog_id, :dependent => :destroy
  has_many :skills, :through => :dog_skill_relationships

  def age
    return { :years => 0, :months => 0, :days => 0 } if self.birthday.nil?
    date_diff_to(self.birthday)
  end

  def age_in_words
    a = age
    "" if a.nil?
    str = ""
    str << "#{a[:years]} years " unless a[:years] <= 0
    str << "#{a[:months]} months " unless a[:months] <= 0
    str << "#{a[:days]} days " unless a[:days] <= 0
    str
  end

end
