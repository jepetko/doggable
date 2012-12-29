class Dog < ActiveRecord::Base
  attr_accessible :birthday, :name
  validates :user_id, :presence => true
  validates :name, :presence => true

  belongs_to :user

  def age
    self.birthday.diff_to_now
  end

  def age_in_words
    a = age
    str = ""
    str << "#{a[:years]} years " unless a[:years] <= 0
    str << "#{a[:months]} months " unless a[:months] <= 0
    str << "#{a[:days]} days " unless a[:days] <= 0
  end
end
