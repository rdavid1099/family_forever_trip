module DateHelper
  def self.time_until_vacation
    today = Date.today
    trip_date = Date.new(2019, 10, 5)
    total_days = (trip_date - today).to_i
    time = total_days/30 > 0 ? total_days/30 : total_days%30
    time_term = total_days/30 > 0 ? 'month' : 'day'
    minutes = total_days * 1440
    {
      complete: "#{time == 1 ? 'is' : 'are'} about #{time} #{time_term.pluralize(time)}",
      days: "#{total_days} #{'day'.pluralize(total_days)}",
      minutes: "#{minutes} #{'minute'.pluralize(minutes)}"
    }
  end
end
