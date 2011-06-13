require "logger"

if Rails.env == "test"
   LOG = Logger.new("reach.log")
else
   LOG = Logger.new(STDOUT)
end
