module PagesHelper
   def seconds_to_minutes(seconds)
      minutes = (seconds.to_i / 60).round
      remaining_seconds = seconds.to_i - (minutes * 60)
      remaining_seconds_formatted = remaining_seconds < 10 ? "0#{remaining_seconds}" : "#{remaining_seconds}"
      "#{minutes}:#{remaining_seconds_formatted}"
   end
end
