$(function() {
   sorttable.finished_sort = function() {
      $('#last_day_of_stats tr').each(function(index) {
         var row = $('#last_day_of_stats tr:nth-child(' + index + ')')
         row.removeClass('regular')
         row.removeClass('alternate')
         if (index % 2 == 0) {
            row.addClass('regular')
         } else {
            row.addClass('alternate')
         }
      })
   }
})
