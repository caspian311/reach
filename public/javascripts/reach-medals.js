$(function() {
   if ($('#selected_medals').size() == 0) {
      return
   }

   $('#selected_medals').focus()

   $('#selected_medals').change(function() {
      var url = '/medals/' + $('#selected_medals').val()
      window.location.href = url
   })

   $('#selected_medals').keyup(function() {
      var url = '/medals/' + $('#selected_medals').val()
      window.location.href = url
   })
})
