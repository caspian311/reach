ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/game_history" => "game_history#show"
   match "/game_history_info" => "game_history_info#index"
   match "/game_details/:reach_id" => "game_details#show"
   match "/game_history/:page" => "game_history#show"

   match "/kill_death_spread" => "kill_death_spread#index"

   match "/player_effectiveness" => "player_effectiveness#index"
   match "/player_effectiveness/:map_id" => "player_effectiveness#show"
   match "/player_effectiveness_info" => "player_effectiveness_info#index"

   match "/players" => "players#index"
   match "/players/:id" => "players#show"
   match "/player_stats/:player_id" => "player_stats#get_stats"
   match "/player_stats/:player_id/:map_id" => "player_stats#get_stats"

   match "/admin" => "admin#index"
   match "/admin/update" => "admin#update"
   match "/admin/results" => "admin#results"

   root :to => "home#index"
end
