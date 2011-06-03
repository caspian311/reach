class GameHistoryController < ActionController::Base
   GAMES_PER_PAGE = 10

   layout "application"

   def show
      @page = params[:page]
      if @page == nil
         @page = 0
      else
         @page = @page.to_i
      end
      @title = "Game History"

      @total_pages = ReachGame.all.count / 10

      all_pages = (0..@total_pages).to_a

      @pages = all_pages

      @games = ReachGame.offset(@page * GAMES_PER_PAGE).limit(GAMES_PER_PAGE).find(:all, :order => "timestamp DESC")
   end
end
