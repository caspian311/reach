class AdminController < ActionController::Base
   layout "application"

   def index
      @title = "Admin"
   end

   def update
      AdminModel.start_job

      render_content("")
   end

   def results
      render_content(AdminModel.current_status.to_json)
   end

   def render_content(content)
      respond_to do |format|
         format.html { 
            render :json => content
         }
         format.json {
            render :json => content
         }
      end
   end
end
