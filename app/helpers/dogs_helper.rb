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

module DogsHelper
end
