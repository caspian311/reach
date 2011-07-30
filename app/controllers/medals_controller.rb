class MedalsController < ActionController::Base
   layout "application"

   def index
      @title = "Medals"
      @medals = Medal.all(:order => :name)
   end

   def show
      @title = "Medals"
      @medals = Medal.all(:order => :name)

      medal_id = params[:medal_id]

      @selected_medal = Medal.find(medal_id)
      @ranked_medals = ReachPlayerMedal.all(
         :select => "players.real_name, sum(reach_player_medals.count) as total",
         :joins => {:reach_player_stat => :player},
         :conditions => {:reach_player_medals => {:medal_id => medal_id}},
         :group => "players.real_name",
         :order => "total desc"
      )
   end
end
