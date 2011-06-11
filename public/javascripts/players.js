
$(document).ready(
   function(){
      $('#player_selector').change(
         function(event) {
            var player_id = $('#player_selector').val()
            window.location.href = '/players/' + player_id
         }
      )

      var selected_player = $('#player_selector').val()

      update_kill_death_graph(selected_player)
      update_effectiveness_graph(selected_player)

      $('#player_maps').change(
         function(event) {
            var selected_map = $('#player_maps').val()

            update_kill_death_graph(selected_player, selected_map)
            update_effectiveness_graph(selected_player, selected_map)
         }
      )

      function update_kill_death_graph(selected_player, selected_map) {
         var kill_death_graph_container = $('#kill_death_graph_container')
         var kill_death_graph = $('#kill_death_graph')

         var url = '/player_stats/kill_deaths/' + selected_player
         if (selected_map){
            url += '/' + selected_map
         }

         $.getJSON(url, function(data) {
            var graph_data = data["graph_data"]

            var options = {
               legend: {
                  show: true,
                  position: "nw",
                  container: $('#kill_death_map_legend')
               },
               xaxis: {
                  ticks: 10
               },
               yaxis: {
                  ticks: 5
               },
               grid: {
                  backgroundColor: { colors: ["#fff", "#ccc"] }
               }, colors: ["#006DAD", "#FF2600"]
            }

            kill_death_graph_container.css('display', 'block')
            $.plot(kill_death_graph, graph_data, options)
         })
      }

      function update_effectiveness_graph(selected_player, selected_map) {
         var effectiveness_graph_container = $('#effectiveness_graph_container')
         var effectiveness_graph = $('#effectiveness_graph')

         var url = '/player_stats/effectiveness/' +  selected_player
         if (selected_map){
            url += '/' + selected_map
         }

         effectiveness_graph.html = ''

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
               }, colors: ["#006DAD", "#FF2600"]
            }

            effectiveness_graph_container.css('display', 'block')
            $.plot(effectiveness_graph, graph_data, options)
         })
      }
   }
)
