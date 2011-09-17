class KillDeathSpreadController < ApplicationController
   def index
      @title = "Average Kill/Death Spread"

      @player_stats = KillDeathSpreadModel.average_stats
   end
end
