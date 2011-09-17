class HomeController < ApplicationController
   def index
      @title = "Halo Reach Stats"

      @todays_stats = HomeModel.todays_stats
      @last_day_of_stats = HomeModel.last_day_of_stats
   end
end
