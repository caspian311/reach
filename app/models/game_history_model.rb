class GameHistoryModel
   GAMES_PER_PAGE = 10

   def self.find_by_reach_id(reach_id)
      ReachGame.where(:reach_id  => reach_id).first
   end

   def self.games_for_page(page)
      ReachGame.offset(page * GAMES_PER_PAGE).limit(GAMES_PER_PAGE).find(:all, :order => "game_time DESC")
   end

   def self.page_for_game(id)
      2
   end
end
