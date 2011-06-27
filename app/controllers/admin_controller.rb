class AdminController < ActionController::Base
   layout "application"

   def index
      @title = "Admin"

      @all_jobs = AdminModel.all_jobs

      @selected_job_id = params[:job_id].to_i

      running_job = AdminModel.running_job
      @is_job_running = running_job != nil

      if @selected_job_id == nil or @selected_job_id == 0
         @selected_job = running_job
      else
         @selected_job = AdminModel.get_job(@selected_job_id)
      end
   end
end
