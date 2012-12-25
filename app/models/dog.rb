if !Date.instance_method_names.include?("diff_to_now")
  class Date
    def diff_to_now
      now = Date.today
      year_diff = now.year - self.year
      month_diff = now.month - self.month
      day_diff = now.day - self.day
      if (day_diff < 0)
        day_diff += 30
        month_diff -= 1
      end
      if (month_diff < 0)
        month_diff += 12
        year_diff -= 1
      end
      {:years => year_diff, :months => month_diff, :days => day_diff}
    end
  end
end

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
