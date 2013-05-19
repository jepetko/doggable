class Dog < ActiveRecord::Base
  include DogsHelper
  attr_accessible :birthday, :name, :skill_ids, :picture, :sex
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :sex, :presence => true, :inclusion => %w{f m}
  validates_attachment :picture, :size => { :in => 0..1024.kilobytes }

  belongs_to :user

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/:style/missing.png"

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

  def get_recent_n(count)
    self.select(:name, :picture).order("created_at DESC").limit(count)
  end

end
