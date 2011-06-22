$(function(){
   if ($('#admin-status').html() == "Running") {
      update_admin_screen()
   }

   $('#admin-update').click(function() {
      $('#admin-update').attr('disabled', 'disabled')

      $.getJSON('/admin/update', function(data) {
         $('#admin-job-id').val(data['job_status']['id'])
         update_admin_screen()
      })
   })

   function update_admin_screen() {
      var results_url = '/admin/results/' + $('#admin-job-id').val()
      var thread_id = setInterval(function() {
         $.getJSON(results_url, function(data) {
            var job_id = data['job_status']['id']
            var status = data['job_status']['status']
            var content = data['job_status']['content']

            $('#admin-status').html(status)
            $('#admin-results').val(content)
            $('#admin-job-id').val(job_id)

            if (status == 'Finished') {
               clearInterval(thread_id)
               $('#admin-update').removeAttr("disabled")
            }
         })
      }, 1000)
   }
})

