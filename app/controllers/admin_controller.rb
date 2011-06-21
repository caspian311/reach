class AdminController < ActionController::Base
   layout "application"

   def index
      @title = "Admin"
   end

   def update
      json = ""

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
