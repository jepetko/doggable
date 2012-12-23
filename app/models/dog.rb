class Dog < ActiveRecord::Base
  attr_accessible :birthday, :name
  validates :user_id, :presence => true
  validates :name, :presence => true

  belongs_to :user
end
