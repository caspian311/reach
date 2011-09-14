class GameHistoryController < ActionController::Base
   GAMES_PER_PAGE = 10

   layout "application"

   def show
      @page = current_page(params)
      @title = "Game History"

      @total_pages = ReachGame.all.count / 10

      @pages = pages_to_display(@page, @total_pages)

      @games = ReachGame.offset(@page * GAMES_PER_PAGE).limit(GAMES_PER_PAGE).find(:all, :order => "game_time DESC")
   end

   def info
      @title = "Game History"
   end

   private
   def current_page(params)
      @page = params[:page]
      if @page == nil
         @page = 0
      else
         @page = @page.to_i
      end
   end

   def pages_to_display(current_page, total_pages)
      all_pages = (0..total_pages).to_a

      if all_pages.length > 5
         if current_page < 3 # at the beginning, show first 5
            display_pages = all_pages.first(5)
         elsif current_page > (total_pages - 4) # at the end, show last 5
            display_pages = all_pages.last(5)
         else # otherwise, show 2 before and 2 after current page
            display_pages = all_pages[(current_page - 2)..(current_page + 2)]
         end
      else
         display_pages = all_pages
      end

      display_pages
   end
end
