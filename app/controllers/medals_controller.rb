class MedalsController < ApplicationController
   def index
      @title = "Medals"
      @medals = ReachPlayerMedal.earned_medals
   end

   def show
      @medals = ReachPlayerMedal.earned_medals

      medal_id = params[:medal_id]

      @selected_medal = Medal.find(medal_id)
      @title = "Medals: #{@selected_medal.name}"
      @ranked_medals = ReachPlayerMedal.ranked_medals(medal_id)
   end
end
