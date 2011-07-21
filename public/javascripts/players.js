$(function(){
   if ($('#selected_player').length == 0) {
      return
   }

   $('#player-graphs-kill_death-tab').click(show_kill_death_graph)
   $('#player-graphs-effectiveness-tab').click(show_effectiveness_graph)

   show_kill_death_graph()

//   update_graphs()

//   $('#player_maps').change(
//      function(event) {
//         update_graphs()
//      }
//   )

   function show_kill_death_graph() {
      var graph_type = 'kill_death'

      select_tab(graph_type)
      create_graph_containers(graph_type)
      update_graphs(graph_type)
   }

   function show_effectiveness_graph() {
      var graph_type = 'effectiveness'

      select_tab(graph_type)
      create_graph_containers(graph_type)
      update_graphs(graph_type)
   }

   function select_tab(graph_type) {
      $('#player-graphs-tabs-container .tab').removeClass('selected')
      $('#player-graphs-tabs-container .tab-content').removeClass('selected')
      $('#player-graphs-' + graph_type + '-tab').addClass('selected')
      $('#player-graphs-' + graph_type + '-body').addClass('selected')

      $('#player-graphs-' + graph_type + '-body').append("<div style=\"text-align:center\"></div>")
   }

   function create_graph_containers(graph_type) {
      var graph_container = $('<div id="' + graph_type + '_graph_container" class="graph_container"></div>')
      var map_legend = $('<div id="' + graph_type + '_map_legend" class="legend"></div>')
      var graph = $('<div id="' + graph_type + '_graph" class="graph"></div>')

      graph_container.append(map_legend)
      graph_container.append(graph)

      $('#player-graphs-' + graph_type + '-body').empty().append(graph_container)
   }

   function update_graphs(graph_type) {
      var graph_div = $('#' + graph_type + '_graph')
      graph_div.append('<div style="text-align:center">Loading...</div>')      

      var url = graph_url(graph_type)
      $.getJSON(url, function(data) {
         graph_div.empty()

         var stats_data = data["stats"]
         var graph_meta_data = data["graph_meta_data"]

         var graph_options = {
            legend: {
               show: true,
               position: "nw",
               container: $('#' + graph_type + '_map_legend')
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
            selection: {
               mode: "x"
            },
            colors: ["#006DAD", "#FF2600"]
         }

         graph_div.empty()
         $.plot(graph_div, stats_data, graph_options)
         graph_div.bind("plotselected", function (event, ranges) {
            $.plot(graph_div, stats_data,
               $.extend(true, {}, graph_options, {
                  xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to }
               }))
         })
         var previous_point = null
         graph_div.bind("plothover", function (event, pos, item) {
            if (item) {
               if (previous_point != item.dataIndex) {
                  previous_point = item.dataIndex;

                  $('#game_tool_tip').remove()

                  var content = graph_meta_data[item.dataIndex]

                  show_game_tooltip(content, item.pageX, item.pageY)
               }
            } else {
               $('#game_tool_tip').remove()
               previous_point = null
            }
         })
      })
   }

   function graph_url(graph_type) {
      var selected_map = $('#player_maps').val()
      var selected_player = $('#selected_player').val()
      var url = '/player_stats/' + graph_type + '/' +  selected_player
      if (selected_map){
         url += '/' + selected_map
      }

      return url
   }

   function show_game_tooltip(content, x, y) {
      $('#game_tool_tip').remove()
      $('<div id="game_tool_tip">' + content + '</div>')
         .css({
            position: 'absolute',
            display: 'none',
            top: y + 5,
            left: x + 5,
            border: 'solid 1px #000',
            padding: '2px',
            'z-index': '99',
            'background-color': '#fff',
            opacity: 0.85
         })
         .appendTo('body').fadeIn(500)
   }
})
