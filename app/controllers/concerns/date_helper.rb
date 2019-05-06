module DateHelper
  def self.time_until_vacation
    seconds_left = Time.parse(Date.new(2019, 10, 5).to_s) - Time.now
    minutes_left = seconds_left / 60
    hours_left = minutes_left / 60
    days_left = (hours_left / 24).to_i
    time = total_days/30 > 0 ? total_days/30 : total_days%30
    time_term = total_days/30 > 0 ? 'month' : 'day'
    {
      complete: "#{time == 1 ? 'is' : 'are'} about #{time} #{time_term.pluralize(time)}",
      days: "#{days_left} #{'day'.pluralize(days_left)}",
      minutes: "#{minutes_left.to_i} #{'minute'.pluralize(minutes_left)}",
      seconds: "#{seconds_left.to_i} #{'second'.pluralize(seconds_left)}"
    }
  end
end
