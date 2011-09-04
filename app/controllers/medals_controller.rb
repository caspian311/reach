class MedalsController < ActionController::Base
   layout "application"

   def index
      @title = "Medals"
      @medals = ReachPlayerMedal.earned_medals
   end

   def show
      @title = "Medals"
      @medals = ReachPlayerMedal.earned_medals

      medal_id = params[:medal_id]

      @selected_medal = Medal.find(medal_id)
      @ranked_medals = ReachPlayerMedal.ranked_medals(medal_id)
   end
end
