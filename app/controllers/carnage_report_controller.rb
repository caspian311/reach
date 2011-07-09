class CarnageReportController < ActionController::Base
   def show
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
