class HomeController < ActionController::Base
   layout "application"

   def index
      @title = "Halo Reach Stats"
   end
end
