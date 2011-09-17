class HomeController < ApplicationController
   def index
      @title = "Halo Reach Stats"

      @todays_stats = HomeModel.todays_stats
   end
end
