
$(function(){
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

      var previous_point = null
      $('#kill_death_graph').bind("plothover", function (event, pos, item) {
         if (item) {
            if (previous_point != item.dataIndex) {
               previous_point = item.dataIndex;

               $('#game_tool_tip').remove()

               var content = kill_death_graph_meta_data[item.dataIndex]

               showGameTooltip(content, item.pageX, item.pageY)
            }
         } else {
            $('#game_tool_tip').remove()
            previous_point = null
         }
      })

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
         lines: {
            show: true
         }, 
         points: {
            show: true
         },
         grid: {
            hoverable: true, 
            clickable: true,
            backgroundColor: { colors: ["#fff", "#ccc"] }
         }, colors: ["#006DAD", "#FF2600"]
      }

      var kill_death_graph_meta_data = []

      function update_kill_death_graph(selected_player, selected_map) {
         var url = '/player_stats/kill_deaths/' + selected_player
         if (selected_map){
            url += '/' + selected_map
         }

         $.getJSON(url, function(data) {
            var graph_data = data["graph_data"]
            kill_death_graph_meta_data = data["kill_death_graph_meta_data"]

            $('#kill_death_graph_container').css('display', 'block')
            $.plot($('#kill_death_graph'), graph_data, options)
         })
      }

      function showGameTooltip(content, x, y) {
         $('#game_tool_tip').remove()
         $('<div id="game_tool_tip">' + content + '</div>')
            .css({
               position: 'absolute',
               display: 'none',
               top: y + 5,
               left: x + 5,
               border: 'solid 1px #000',
               padding: '2px',
               'background-color': '#fff',
               opacity: 0.85
            })
            .appendTo('body').fadeIn(500)
      }

      function update_effectiveness_graph(selected_player, selected_map) {
         var url = '/player_stats/effectiveness/' +  selected_player
         if (selected_map){
            url += '/' + selected_map
         }

         $('#effectiveness_graph').html = ''

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

            $('#effectiveness_graph_container').css('display', 'block')
            $.plot($('#effectiveness_graph'), graph_data, options)
         })
      }
   }
)
