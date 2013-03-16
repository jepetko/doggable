module DogsHelper

  def date_diff_to(start_date, end_date = Date.today, ignore_future = true)
    year_diff = end_date.year - start_date.year
    month_diff = end_date.month - start_date.month
    day_diff = end_date.day - start_date.day
    if (day_diff < 0)
      day_diff += 30
      month_diff -= 1
    end
    if (month_diff < 0)
      month_diff += 12
      year_diff -= 1
    end
    return {:years => 0, :months => 0, :days => 0} if ignore_future && (year_diff < 0 || month_diff < 0 || day_diff < 0)
    {:years => year_diff, :months => month_diff, :days => day_diff}
  end

end
