
$(document).ready(
   function() {
      $('#maps').change(
         function(event) {
            map = $('#maps').val()
            window.location = '/player_effectiveness/' + map
         }
      )
   }
)

