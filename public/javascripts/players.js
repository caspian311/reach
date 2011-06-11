
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
            var graph_container = $('#effectiveness_graph_container')
            var graph = $('#effectiveness_graph')

            var url = '/players/' +  selected_player + '/' + player_map

            graph.html = ''

            if (player_map.length) {
               $.getJSON(url, function(data) {
                  var graph_data = data["graph_data"]

                  var options = {
                     legend: {
                        show: true,
                        position: "nw",
                        container: $('#player_map_legend')
                     },
                     xaxis: {
                        ticks: 10
                     },
                     yaxis: {
                        ticks: 5
                     },
                     grid: {
                        backgroundColor: { colors: ["#fff", "#ccc"] }
                     }
                  }

                  graph_container.css('display', 'block')
                  $.plot(graph, graph_data, options)
               })
            } else {
                  graph_container.css('display', 'none')
            }
         }
      )
   }
)
