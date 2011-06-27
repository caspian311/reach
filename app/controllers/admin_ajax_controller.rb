class AdminAjaxController < ActionController::Base
   def update
      job_status = AdminModel.start_job

      render_content(job_status.to_json)
   end

   def results
      job_id = params[:job_id].to_i
      current_status = AdminModel.get_job(job_id)

      render_content(current_status.to_json)
   end

   def all_jobs
      all_jobs = AdminModel.all_jobs

      render_content(all_jobs.to_json)
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
