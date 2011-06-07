ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/game_history" => "game_history#show"
   match "/game_history/:page" => "game_history#show"
   match "/kill_death_spread" => "kill_death_spread#index"
   match "/player_effectiveness" => "player_effectiveness#index"
   match "/player_effectiveness/:map_name" => "player_effectiveness#show"
   match "/player_effectiveness_info" => "player_effectiveness_info#index"

   root :to => "home#index"
end
