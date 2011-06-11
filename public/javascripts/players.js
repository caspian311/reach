
$(document).ready(
   function(){
      $('#player_selector').change(
         function(event) {
            var player_id = $('#player_selector').val()
            window.location.href = '/players/' + player_id
         }
      )

      $('#player_maps').change(
         function(event) {
            var selected_player = $('#player_selector').val()
            var player_map = $('#player_maps').val()
            var graph = $('#effectiveness_graph')

            var url = '/players/' +  selected_player + '/' + player_map

            if (player_map.length) {
               $.getJSON(url, function(graph_data) {
                  $.plot(graph, graph_data)
                  graph.css('visibility', 'visible')
               })
            } else {
                  graph.css('visibility', 'hidden')
            }
         }
      )
   }
)
