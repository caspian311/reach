class MedalsController < ActionController::Base
   layout "application"

   def index
      @title = "Medals"
      @medals = Medal.earned_medals
   end

   def show
      @title = "Medals"
      @medals = Medal.earned_medals

      medal_id = params[:medal_id]

      @selected_medal = Medal.find(medal_id)
      @ranked_medals = ReachPlayerMedal.ranked_medals(medal_id)
   end
end
