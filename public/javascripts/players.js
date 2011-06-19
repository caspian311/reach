
$(function(){
      $('#player_selector').change(
         function(event) {
            var player_id = $('#player_selector').val()
            window.location.href = '/players/' + player_id
         }
      )

      var selected_player = $('#player_selector').val()

      update_graphs(selected_player)

      $('#player_maps').change(
         function(event) {
            var selected_map = $('#player_maps').val()

            update_graphs(selected_player, selected_map)
         }
      )

      $('#kill_death_graph').bind("plothover", plot_hover)
      $('#effectiveness_graph').bind("plothover", plot_hover)

      var previous_point = null
      function plot_hover(event, pos, item) {
         if (item) {
            if (previous_point != item.dataIndex) {
               previous_point = item.dataIndex;

               $('#game_tool_tip').remove()

               var content = graph_meta_data[item.dataIndex]

               showGameTooltip(content, item.pageX, item.pageY)
            }
         } else {
            $('#game_tool_tip').remove()
            previous_point = null
         }
      }

      var options = {
         legend: {
            show: true,
            position: "nw"
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
            backgroundColor: { colors: ["#fff", "#ccc"] }
         }, 
         colors: ["#006DAD", "#FF2600"]
      }

      var graph_meta_data = []

      function update_graphs(selected_player, selected_map) {
         var url = '/player_stats/' +  selected_player
         if (selected_map){
            url += '/' + selected_map
         }

         $('#effectiveness_graph').html = ''
         $('#kill_death_graph').html = ''

         $.getJSON(url, function(data) {
            var kill_death_data = data["kill_death"]
            var effectiveness_data = data["effectiveness"]
            graph_meta_data = data["graph_meta_data"]

            $('#effectiveness_graph_container').css('display', 'block')
            $('#kill_death_graph_container').css('display', 'block')

            options["legend"]["container"] = $('#kill_death_map_legend')
            $.plot($('#kill_death_graph'), kill_death_data, options)

            options["legend"]["container"] = $('#effectiveness_map_legend')
            $.plot($('#effectiveness_graph'), effectiveness_data, options)
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
   }
)
