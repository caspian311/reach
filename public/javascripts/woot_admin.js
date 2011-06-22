$(function(){
   $('#admin-update').click(function() {
      $.getJSON('/admin/update', function(data) {
         var results_url = '/admin/results/' + data['job_status']['id']

         var thread_id = setInterval(function() {
            $.getJSON(results_url, function(data) {
               var status = data['job_status']['status']
               var content = data['job_status']['content']

               $('#admin-status').html(status)
               $('#admin-results').val(content)

               if (status == 'finished') {
                  clearInterval(thread_id)
               }
            })
         }, 1000)
      })
   })
})

