$(function(){
   if ($('#selected_player').length == 0) {
      return
   }

   $('#player-graphs-kill_death-tab').click(show_kill_death_graph)
   $('#kill_death_player_maps').change(show_kill_death_graph)
   $('#player-graphs-medals-tab').click(show_medals_graph)
   $('#player-graphs-effectiveness-tab').click(show_effectiveness_graph)
   $('#effectiveness_player_maps').change(show_effectiveness_graph)

   show_kill_death_graph()

   function show_kill_death_graph() {
      show_stats('kill_death')
   }

   function show_medals_graph() {
      var graph_type = 'medals'

      select_tab(graph_type)
      create_graph_containers(graph_type)
      fetch_bar_graph(graph_type)
   }

   function show_effectiveness_graph() {
      show_stats('effectiveness')
   }

   function show_stats(graph_type) {
      select_tab(graph_type)
      create_graph_containers(graph_type)
      fetch_line_graph(graph_type)
   }

   function select_tab(graph_type) {
      $('#player-graphs-tabs-container .tab').removeClass('selected')
      $('#player-graphs-tabs-container .tab-content').removeClass('selected')
      $('#player-graphs-' + graph_type + '-tab').addClass('selected')
      $('#player-graphs-' + graph_type + '-body').addClass('selected')
   }

   function create_graph_containers(graph_type) {
      var graph_container = $('<div id="' + graph_type + '_graph_container" class="graph_container"></div>')
      var map_legend = $('<div id="' + graph_type + '_map_legend" class="legend"></div>')
      var graph = $('<div id="' + graph_type + '_graph" class="graph"></div>')

      graph_container.append(map_legend)
      graph_container.append(graph)

      $('#player-graphs-' + graph_type).empty().append(graph_container)
   }

   function fetch_line_graph(graph_type) {
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
            $.plot(graph_div, stats_data, $.extend(true, {}, graph_options, {
                  xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to }
               }))
         })
         graph_div.bind("plothover", function (event, pos, item) {
            if (item) {
               var content = graph_meta_data[item.dataIndex]
               show_graph_tooltip(content, item.pageX, item.pageY)
            } else {
               $('#game_tool_tip').remove()
            }
         })
      })
   }

   function fetch_bar_graph(graph_type) {
      var graph_div = $('#' + graph_type + '_graph')
      graph_div.append('<div style="text-align:center">Loading...</div>')      

      var url = graph_url(graph_type)
      $.getJSON(url, function(data) {
         graph_div.empty()

         var stats_data = data["stats"]
         var graph_meta_data = data["graph_meta_data"]

         var graph_options = {
            bars: {
               show: true
            }, 
            lines: {
               show: false
            }, 
            points: {
               show: false
            },
            xaxis: {
               show: false
            },
            grid: {
               hoverable: true,
               backgroundColor: { colors: ["#fff", "#ccc"] }
            }, 
            colors: ["#006DAD"]
         }

         graph_div.empty()
         $.plot(graph_div, stats_data, graph_options)
         graph_div.bind("plothover", function (event, pos, item) {
            if (item) {
               var content = graph_meta_data[item.dataIndex]
               show_graph_tooltip(content, item.pageX, item.pageY)
            } else {
               $('#game_tool_tip').remove()
            }
         })
      })
   }

   function graph_url(graph_type) {
      var url = '/player_stats/' + graph_type + '/' + $('#selected_player').val()

      if (graph_type == 'effectiveness' || graph_type == 'kill_death') {
         var selected_map = $('#' + graph_type + '_player_maps').val()
         if (selected_map){
            url += '/' + selected_map
         }
      }

      return url
   }

   function show_graph_tooltip(content, x, y) {
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
