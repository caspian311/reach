ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/game_history" => "game_history#show"
   match "/game_history/info" => "game_history#info"
   match "/game_details/:reach_id" => "game_details#show"
   match "/game_history/:page" => "game_history#show"

   match "/kill_death_spread" => "kill_death_spread#index"

   match "/player_effectiveness" => "player_effectiveness#index"
   match "/player_effectiveness/:map_id" => "player_effectiveness#show"
   match "/player_effectiveness_info" => "player_effectiveness_info#index"

   match "/players" => "players#index"
   match "/players/:id" => "players#show"

   match "/player_stats/kill_death/:player_id" => "player_stats#kill_death_stats"
   match "/player_stats/kill_death/:player_id/:map_id" => "player_stats#kill_death_stats_for_map"

   match "/player_stats/effectiveness/:player_id" => "player_stats#effectiveness_stats"
   match "/player_stats/effectiveness/:player_id/:map_id" => "player_stats#effectiveness_stats_for_map"

   match "/player_stats/medals/:player_id" => "player_stats#medal_stats"

   match "/admin" => "admin#index"
   match "/admin/:job_id" => "admin#index"
   match "/admin-ajax/update" => "admin_ajax#update"
   match "/admin-ajax/results/:job_id" => "admin_ajax#results"
   match "/admin-ajax/all_jobs" => "admin_ajax#all_jobs"

   match "/carnage_report/:player_stat_id" => "carnage_report#show"
   match "/medals_history/:player_stat_id" => "medals_history#show"

   match "/medals" => "medals#index"
   match "/medals/:medal_id" => "medals#show"

   root :to => "home#index"
end
