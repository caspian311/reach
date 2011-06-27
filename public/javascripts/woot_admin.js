$(function(){
   $('#admin-job-selection').change(function(event) {
      var job_id = $('#admin-job-selection').val()
      window.location.href = '/admin/' + job_id
   })

   if ($('#admin-status').html() == "Running") {
      continuously_update_admin_screen()
   }

   $('#admin-update').click(function() {
      $('#admin-update').attr('disabled', 'disabled')

      $.getJSON('/admin-ajax/update', function(data) {
         var new_job_id = data['job_status']['id']
         window.location.href = '/admin/' + new_job_id
      })
   })
})

function continuously_update_admin_screen() {
   var results_url = '/admin-ajax/results/' + $('#admin-job-id').val()
   var thread_id = setInterval(function() {
      $.getJSON(results_url, function(data) {
         var job_id = data['job_status']['id']
         var status = data['job_status']['status']
         var content = data['job_status']['content']

         $('#admin-job-id').val(job_id)
         $('#admin-status').html(status)
         $('#admin-results').html(content)
         $('#admin-results-container').scrollTo('max')

         if (status != 'Running') {
            clearInterval(thread_id)

            update_job_dropdown()
            $('#admin-update').removeAttr("disabled")
         }
      })
   }, 500)
}

function update_job_dropdown() {
   $.getJSON('/admin-ajax/all_jobs', function(data){
      $('#admin-job-selection').find('option').remove().append('<option></option>')
      for (var i=0; i<data.length; i++) {
         var job = data[i]['job_status']
         var option = null
         if ($('#admin-job-id').val() == job['id']) {
            option = '<option value="' + job['id'] + '" selected="selected">' + job['created_at'] + ' - ' +  job['status'] + '</option>'
         } else {
            option = '<option value="' + job['id'] + '">' + job['created_at'] + ' - ' +  job['status'] + '</option>'
         }
         $('#admin-job-selection').append(option)
      }
   })
}
