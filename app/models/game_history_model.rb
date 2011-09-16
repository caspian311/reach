class GameHistoryModel
   GAMES_PER_PAGE = 10

   def self.find_by_reach_id(reach_id)
      ReachGame.where(:reach_id  => reach_id).first
   end

   def self.games_for_page(page)
      ReachGame.offset(page * GAMES_PER_PAGE).limit(GAMES_PER_PAGE).find(:all, :order => "game_time DESC")
   end

   def self.page_for_game(game_id)
      ordinal_index = 0
      ReachGame.find(:all, :order => "game_time DESC").each_with_index do |game, index|
         ordinal_index = (index + 1)
         break if game.id.to_i == game_id.to_i
      end
      (ordinal_index.to_f / GAMES_PER_PAGE.to_f).ceil - 1
   end
end
