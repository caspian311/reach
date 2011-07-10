class CarnageReportController < ActionController::Base
   def show
      player_stat_id = params[:player_stat_id]

      weapon_carnage_reports = ReachWeaponCarnageReport.find_by_player_stat_id(player_stat_id)

      json = weapon_carnage_reports.to_json(:include => :weapon)

      respond_to do |format|
         format.html { 
            render :json => json
         }
         format.json {
            render :json => json
         }
      end
   end
end
