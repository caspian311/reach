class AdminController < ActionController::Base
   layout "application"

   def index
      @title = "Admin"
   end

   def update
      job_status = AdminModel.start_job

      render_content(job_status.to_json)
   end

   def results
      job_id = params[:job_id].to_i
      current_status = AdminModel.current_status(job_id)

      render_content(current_status.to_json)
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
