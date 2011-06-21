$(function(){
   $('#admin-update').click(function() {
      $.getJSON('/admin/update', function(data) {
         var thread_id = setInterval(500, function() {
            $.getJSON('/admin/results', function(data) {
               if (data['results']['status'] == 'not started') {
                  $('#admin-results').val('Not started yet...')
               } else if (data['results']['status'] == 'running') {
                  var content = data['results']['text']
                  $('#admin-results').val($('#admin-results').val() + content)
               } else if (data['results']['status'] == 'finished') {
                  clearInterval(thread_id)
               }
            }
         })
      })
   })
})
